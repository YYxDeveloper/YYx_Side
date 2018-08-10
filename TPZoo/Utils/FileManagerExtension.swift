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
