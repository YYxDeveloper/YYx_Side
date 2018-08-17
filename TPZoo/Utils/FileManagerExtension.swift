//
//  FileManagerExtension.swift
//  TPZoo
//
//  Created by HSI on 2018/8/10.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
extension FileManager{
    enum fileType:String {
        case jpg
    }
    class func loadBundleFile(name:String,type:String)throws -> String{
        //    https://www.hackingwithswift.com/example-code/strings/how-to-load-a-string-from-a-file-in-your-bundle
        guard let filepath = Bundle.main.path(forResource: name, ofType: type)  else {
            return "\(ERORR_PREFIX)\(#file):\(#line)"
        }
        
        let contents = try String(contentsOfFile: filepath)
        return contents
    }
    class func isFileExsit(fileName:String,type:fileType)  {
       
        
        switch type {
        case .jpg:
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            if let pathComponent = url.appendingPathComponent("\(fileName).jpg") {
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    print("FILE AVAILABLE")
                } else {
                    print("FILE NOT AVAILABLE")
                }
            } else {
                print("FILE PATH NOT AVAILABLE")
            }
        }
        
    }
}
