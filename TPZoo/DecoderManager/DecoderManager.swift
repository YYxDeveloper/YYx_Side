//
//  DecoderManager.swift
//  TPZoo
//
//  Created by HSI on 2018/7/24.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
class DecoderManager {
    static let sharedInstance =  DecoderManager()
    var animalsData:[AnimalsDataModel.animals]{
        do {
            let content = try loadBundleFile(name: "AnimalsJSONData", type: "txt")
            let JsonData = try JSONDecoder().decode(AnimalsDataModel.self, from: content.data(using: .utf8)!)
             return JsonData.result.results
        } catch  {
            print("\(ERORR_PREFIX)\(error.localizedDescription)")
            return [AnimalsDataModel.animals]()
        }
    }
    
    private func loadBundleFile(name:String,type:String)throws -> String{
        //    https://www.hackingwithswift.com/example-code/strings/how-to-load-a-string-from-a-file-in-your-bundle
        guard let filepath = Bundle.main.path(forResource: name, ofType: type)  else {
            return "\(ERORR_PREFIX)\(#file):\(#line)"
        }

        let contents = try String(contentsOfFile: filepath)
        return contents
    }
}
