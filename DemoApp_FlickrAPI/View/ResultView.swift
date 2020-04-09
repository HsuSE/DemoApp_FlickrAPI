//
//  FeaturedView.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/7.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var text: String
    var per_page: Int
    @State private var selectedTab = true
    
    var body: some View {
        
        TabView {
            FeaturedView(text: text, per_page: per_page).tabItem {
                NavigationLink(destination: FeaturedView(text: text, per_page: per_page)) {
                        Image(systemName: "star.fill")
                            .imageScale(.large)
                        Text("Featured")
                }
            }.padding(.bottom, 1)
            .environment(\.managedObjectContext, context)
            
            
            FavoritedView().tabItem {
                NavigationLink(destination: FavoritedView()) {
                    Image(systemName: "star.fill")
                        .imageScale(.large)
                    Text("Favorites")
                }
            }.padding(.bottom, 1)
            .navigationBarHidden(true)
        }
        .navigationBarTitle(Text("搜尋結果 \(self.text)"), displayMode: .inline)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(text: "test", per_page: 3)
    }
}
