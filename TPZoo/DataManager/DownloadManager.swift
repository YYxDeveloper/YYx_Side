//
//  DownloadManager.swift
//  TPZoo
//
//  Created by HSI on 2018/8/10.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import SDWebImage
import PKHUD
import Alamofire

class DownloadManager {
    static let shared =  DownloadManager()
    var downloadRequest:DownloadRequest?
    var destination:DownloadRequest.DownloadFileDestination!
    /// 用于停止下载时，保存已下载的部分
    var cancelledData: Data?
    var progressValue:Float?{didSet{ print("下載進度：\(progressValue!)") }}
    
    /**
     1. put HUD.show(.progress) in viewWillLayoutSubviews
     2. put this func in viewDidAppear
     otherwiese indicator will appear lately
     */
    func downloadAnimalsImages(){
      
        let arr  = AnimalDataManager.shared.animalsImages
        for data in arr{
            if let url1 = data.url1,let alt1 = data.alt1 {
                DownloadManager.shared.setupDownloadRequest(URLString: url1, fileName: "\(alt1)Alt2", singleDownload: false)
            }
            if let url2 = data.url2,let alt2 = data.alt2 {
                DownloadManager.shared.setupDownloadRequest(URLString: url2, fileName: "\(alt2)Alt2", singleDownload: false)
            }
            if let url3 = data.url3,let alt3 = data.alt3 {
                DownloadManager.shared.setupDownloadRequest(URLString: url3, fileName: "\(alt3)Alt3", singleDownload: false)
            }
            if let url4 = data.url4,let alt4 = data.alt4 {
                DownloadManager.shared.setupDownloadRequest(URLString: url4, fileName: "\(alt4)Alt4", singleDownload: false)
            }
        }
    }
    func setupDownloadRequest(URLString:String,fileName:String,singleDownload:Bool) {
        if singleDownload {
            HUD.show(.progress)
        }
        destination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("\(fileName).jpg")
            print(fileURL)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        /// 开始下载
        downloadRequest = Alamofire.download(URLString, to: destination)
        downloadRequest?.downloadProgress(queue: DispatchQueue.main, closure: downloadProgress(progress:))
        downloadRequest?.responseData(completionHandler: downloadResponse)
    }
//MARK: private
    @objc fileprivate func downloadProgress(progress: Progress) {
        /// 进度条更新
        self.progressValue = Float(progress.fractionCompleted)

    }
    
    private func downloadResponse(response: DownloadResponse<Data>) {
        HUD.hide(afterDelay: 1)//不delay
        switch response.result {
        case .success(let dataSize):
            print("文件下载完毕: \(response),data size:\(dataSize)")
        case .failure:
            cancelledData = response.resumeData //意外终止的话，把已下载的数据储存起来
        }
    }
//MARK: class
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    class func isNetworkConnection() -> Bool{
//        let current = UIApplication.shared.delegate?.window??.visibleViewController
//        guard let currentVC = current else {return false}
        guard Reachability.isConnectedToNetwork() == true else {
            print("\(ReturnString.yyxNoNewtwork.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
            return false }
        return true
        //        guard Reachability.isConnectedToNetwork() == true else { return currentVC.view.makeToast("請確認網路連線") }
    }
   
}
