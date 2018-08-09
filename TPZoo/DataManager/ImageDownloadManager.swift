//
//  File.swift
//  TPZoo
//
//  Created by HSI on 2018/8/8.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import SDWebImage
import PKHUD
class ImageDownloadManager {
    static let shared =  ImageDownloadManager()
    
    
    
    
    
    
    func downloadJpgImage(url:String,fileName:String) {
        guard isNetworkConnection() else {
            print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
            return
        }
        HUD.show(.progress)
        let manager = SDWebImageManager.shared()
        manager.imageDownloader?.downloadImage(with: URL(string: url), options: [] , progress: {progress,task,url in
            let percent = Float(progress)/Float(task)
        }, completed: {optionImage,data,error,bool in
            HUD.hide()
            guard let image = optionImage else {return}
            if let data = UIImageJPEGRepresentation(image, 1.0) {
                let filename = self.getDocumentsDirectory().appendingPathComponent("\(fileName).jpg")
                try? data.write(to: filename)
            }
        })
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    private func isNetworkConnection() -> Bool{
        let current = UIApplication.shared.delegate?.window??.visibleViewController
        guard let currentVC = current else {return false}
        guard Reachability.isConnectedToNetwork() == true else { return false }
        return true
//        guard Reachability.isConnectedToNetwork() == true else { return currentVC.view.makeToast("請確認網路連線") }
    }
}
