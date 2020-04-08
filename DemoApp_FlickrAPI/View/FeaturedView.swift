//
//  ResultView.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/2.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI
import Combine

struct FeaturedView: View {
    @ObservedObject var networkManager: NetworkManager
    
    var text: String
    init (text: String, per_page: Int) {
        networkManager = NetworkManager(text: text, per_page: per_page)
        self.text = text
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(networkManager.coupleItem(), id: \.self) { item in
                    HStack(spacing: 10) {
                        ForEach(item) { photo in
                            FeatureImageCell(id: photo.id,
                                               keyword: self.text,
                                               owner: photo.owner,
                                               title: photo.title,
                                               imageURL: photo.imageURL)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                }
                Button(action: {
                    self.networkManager.fatch()
                }) {
                    Text("Loading...")
                        .frame(width: UIScreen.main.bounds.width)
                        .onAppear { self.networkManager.fatch() }
                }.listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            }.onAppear{
                UITableView.appearance().separatorStyle = .none
            } // List End
            
        }
        .navigationBarTitle("搜尋結果 \(self.text)", displayMode: .inline)
        
    }
    
    
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone X"], id:\.self) { deviceName in
            FeaturedView(text: "test", per_page: 1)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }

    }
}
