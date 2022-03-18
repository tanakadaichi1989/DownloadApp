## DownloadApp
### アプリの内容
・処理の進捗に応じて ProgressView を更新

※ SwiftUI の ProgressView を利用

<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/199441/9acab43c-add3-3391-8863-7e00ea7683d5.png" width="350">

### 開発環境
#### ハードウエア
|項目|内容|
|---|---|
|PC| MacBook Air(M1,2020） メモリ：16GB ストレージ：1TB |

#### ソフトウエア
|項目|内容|
|---|---|
|言語|Swift 5.6|
|IDE|Xcode Ver 13.3|
|バージョン管理|GitHub|

### この処理のイメージ（動画）
https://www.youtube.com/watch?v=3mKahs8Qt7Q

### ポイント
・メインスレッドとは別のスレッドで時間がかかる処理を実行

・上記処理の進捗をクロージャで取得

・処理の途中に Start ボタンを押せないようにする

### コード
#### DownloadManager クラス
・時間のかかる処理を実装している（※今回はダミーの処理を実装した）

・進捗をクロージャに渡す


```swift:DownloadManager.swift
import Foundation

class DownloadManager {
    static func startDownload(completion: @escaping (Int) -> Void){
        print("start Download")
        var progress = 0
        
        // 時間がかかる処理
        DispatchQueue.global().asyncAfter(deadline: .now()){
            while(progress <= 100){
                print(progress)
                completion(progress) // 進捗をクロージャに渡す
                progress += progress < 90 ? Int.random(in: 1...10) : 1
                sleep(1)
            }
        }
    }
}

```

#### 処理の途中に Start ボタンを押せないようにする

```swift:ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var progress:Int = 0
    @State private var canButtonTap:Bool = true
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            ProgressView("\(progress)%",value: Float(progress),total: Float(100))
                .progressViewStyle(.linear)
                .padding()
            Button(action: tapButton,label: {
                Text("Start")
            })
            .disabled(!canButtonTap) // ここでボタンの活性⇄非活性を切り替える
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
    
    private func tapButton(){
        self.canButtonTap = false // ボタンをタップしたら、ボタンを非活性にする ∵ 処理中のボタン２度押しを禁止するため
        DownloadManager.startDownload { progress in
            self.progress = progress // グロージャで渡らせれた進捗状況をビューに表示
            self.toggleButton()
        }
    }
    
    private func toggleButton(){
        if progress == 100 {
            canButtonTap = true // 進捗が 100 であればボタンを押せるようにする
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
