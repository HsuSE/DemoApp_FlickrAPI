//
//  ContentView.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/2.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State var text: String = ""
    @State var per_page: String = ""
    @State var photos: [PhotoDetail]?
    var body: some View {
        NavigationView {
            VStack {
                TextField("欲搜尋內容", text: self.$text) .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 15)
                
                TextField("每頁呈現數量", text: $per_page)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 15)
                    .onReceive(Just(per_page)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.per_page = filtered
                        }
                }
                
                NavigationLink(destination: ResultView(text: self.text, per_page: Int(self.per_page) ?? 0)) {
                        Text("搜尋")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width-20, height: 40)
                        .background(buttonColor)
                        .padding(.bottom, 20)
                }
                .disabled(!textIsValid)
                
                
            }.padding()
            .navigationBarTitle("搜尋輸入頁", displayMode: .inline)
        }
    }
    
    var textIsValid: Bool {
        return !text.isEmpty && !per_page.isEmpty
    }
    
    var buttonColor: Color {
        return textIsValid ? .blue : .gray
    }
    
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone X"], id:\.self) { deviceName in
            SearchView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

