//
//  DownloadManager.swift
//  DownloadApp
//
//  Created by 田中大地 on 2022/03/18.
//

// https://qiita.com/Yaruki00/items/ff991c5f3c2963a14b3a

import Foundation

class DownloadManager {
    static func startDownload(completion: @escaping (Int) -> Void){
        print("start Download")
        var progress = 0
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0){
        while(progress <= 100){
            print(progress)
            completion(progress)
            progress += 1
            sleep(1)
        }
        }
    }
}

