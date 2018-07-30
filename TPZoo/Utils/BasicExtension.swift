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
    static func showFileName(filePath:String) -> String  {
        let ranges = filePath.ranges(of: "/")
        let lastNum = ranges.count
        let fileNameWithDot = filePath[ranges[lastNum - 1].upperBound...]
        let onlyFileName = String(fileNameWithDot.prefix(fileNameWithDot.count - 6))
        return onlyFileName

    }
}
