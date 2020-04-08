//
//  FavoritedPage.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/7.
//  Copyright © 2020 HsuSE. All rights reserved.
//


import SwiftUI
import CoreData
import Combine

struct FavoritedView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: PhotoFavorited.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoFavorited.id, ascending: false)]
    ) var favorites: FetchedResults<PhotoFavorited>
    
    var body: some View {
        VStack(spacing: 1) {
            ScrollView(.vertical) {
                ForEach(setCoupleItem, id:\.self) { favorites in
                    HStack(spacing: 10) {
                        ForEach(favorites) { favorite in
                            FavoritedImageCell(imageData: favorite.imageData!, title: favorite.title!)
                                .onTapGesture {                                    self.delItem(favorite: favorite)
                                }
                            if favorites.count == 1 {
                                Spacer()
                            }
                        }
                        
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }.padding(.top, 10)
                
            }.onAppear{
                UITableView.appearance().separatorStyle = .none
            } // List End
            
        }
        .navigationBarTitle(Text("我的最愛"), displayMode: .inline)
        
        
    }
    
    func delItem(favorite: PhotoFavorited) {
        self.context.delete(favorite.self)
        do {
            try self.context.save()
        } catch {
            print("Error \(error)")
        }
    }
    
    var setCoupleItem: [[PhotoFavorited]] {
        var coupleitem = [[PhotoFavorited]]()
        for idx in stride(from: 0, to: self.favorites.count, by: 2) {
            if idx+1 == self.favorites.count {
                coupleitem += [[self.favorites[idx]]]
                break
            }
            coupleitem += [[self.favorites[idx], self.favorites[idx+1]]]
        }
        return coupleitem
    }
}


struct FavoritedView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedView()
    }
}
