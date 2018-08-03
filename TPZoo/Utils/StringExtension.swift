//
//  BasicExtension.swift
//  TPZoo
//
//  Created by HSI on 2018/7/30.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
extension String {
    func ranges(of string: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        searchedRange = sr
        
        var resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }
    func replace(target: String, withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    static func showFileName(filePath:String) -> String  {
        let ranges = filePath.ranges(of: "/")
        let lastNum = ranges.count
        let fileNameWithDot = filePath[ranges[lastNum - 1].upperBound...]
        let onlyFileName = String(fileNameWithDot.prefix(fileNameWithDot.count - 6))
        return onlyFileName

    }
    static func convertCoordinateStringToDouble(targetString:String) -> [(Double,Double)]  {
        guard targetString != EMPTY_STRING else {
            return [(Double,Double)]()
        }
        let firstIndex = (targetString.range(of: "(" )?.upperBound)!
        let lastIndex  = (targetString.range(of: ")",options: .backwards)?.lowerBound)!
        
        let str1 = String(targetString[firstIndex..<lastIndex])
        //(121.5898494 24.9940697), (121.586726 24.994559), (121.5873295 24.9946641)
        let strs = String(str1).ranges(of: "\\(")
        //get "(" location
        
        var arr = [String]()
        
        for index in 0..<strs.count {
            if index == strs.count - 1{
                arr.append(String(str1[strs[index].lowerBound...]).replace(target: "(", withString: EMPTY_STRING).replace(target: ")", withString: EMPTY_STRING))
            }else{
                arr.append(String(str1[strs[index].lowerBound..<strs[index + 1].lowerBound]).replace(target: "(", withString: EMPTY_STRING).replace(target: "),", withString: EMPTY_STRING))
            }
            
        }
//        print(arr)//["121.5898494 24.9940697 ", "121.586726 24.994559 ", "121.5873295 24.9946641"]
        
        var arr2 = [(Double,Double)]()
        arr.map({
            
            guard let spaceIndex = $0.index(of: Character.init(SPACE_STRING))else {return}
            
            
            if  let lat = Double(String($0[...spaceIndex]).replace(target: SPACE_STRING, withString: EMPTY_STRING)), let lon = Double(String($0[spaceIndex...]).replace(target: SPACE_STRING, withString: EMPTY_STRING)){
                arr2.append((lat,lon))
            }
        })
//        print(arr2)
        return arr2
    }
}

