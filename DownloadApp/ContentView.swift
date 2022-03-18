//
//  ContentView.swift
//  DownloadApp
//
//  Created by 田中大地 on 2022/03/18.
//

import SwiftUI

struct ContentView: View {
    @State private var progress:Int = 0
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
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
    
    private func tapButton(){
        DownloadManager.startDownload { progress in
            self.progress = progress
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
