//
//  ResultView.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/2.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI
import Combine

struct CollectionView: View {
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
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            ForEach(item) { photo in
                                CollectionViewCell(title: photo.title, imageURL: photo.imageURL)
                            }
                        }
                    }
                }
            
                Button(action: {
                    self.networkManager.fatch()
                }) {
                    Text("Loading...")
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom, 20)
                        .onAppear {self.networkManager.fatch()}
                }
            }.onAppear{
                UITableView.appearance().separatorStyle = .none
            }
        }
        .navigationBarTitle("搜尋結果 \(self.text)", displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
            CollectionView(text: "test", per_page: 1)

    }

}
