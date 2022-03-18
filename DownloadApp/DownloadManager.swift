//
//  DownloadManager.swift
//  DownloadApp
//
//  Created by 田中大地 on 2022/03/18.
//

import Foundation

class DownloadManager {
    static func startDownload(completion: @escaping (Int) -> Void){
        print("start Download")
        var progress = 0
        
        DispatchQueue.global().asyncAfter(deadline: .now()){
            while(progress <= 100){
                print(progress)
                completion(progress)
                progress += progress < 90 ? Int.random(in: 1...10) : 1
                sleep(1)
            }
        }
    }
}
