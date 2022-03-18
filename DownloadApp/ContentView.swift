//
//  ContentView.swift
//  DownloadApp
//
//  Created by 田中大地 on 2022/03/18.
//

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
            .disabled(!canButtonTap)
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
    
    private func tapButton(){
        self.canButtonTap = false
        DownloadManager.startDownload { progress in
            self.progress = progress
            self.toggleButton()
        }
    }
    
    private func toggleButton(){
        if progress == 100 {
            canButtonTap = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
