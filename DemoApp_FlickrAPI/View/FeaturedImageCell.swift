//
//  CollectionViewCell.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/4.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI
import Combine


struct FeaturedImageCell: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var imageLoader: ImageLoader
    var title: String
    var id: String
    var keyword: String
    var owner: String
    
    init (id: String, keyword: String, owner: String, title: String, imageURL: URL) {
        self.title = title
        self.id = id
        self.keyword = keyword
        self.owner = owner
        self.imageLoader = ImageLoader(imageURL: imageURL)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: imageWidget)
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2 - 15 ,
                       height: UIScreen.main.bounds.width/2 - 15 )
                .scaledToFit()
                .clipped()
                .overlay(
                    Image(systemName: "heart.fill")
                        .foregroundColor(.pink)
                        .imageScale(.large)
                        .onTapGesture {
                            self.addFavorited(id: self.id, imageData: self.imageLoader.data, keyword: self.keyword, owner: self.owner, title: self.title)
                    }.offset(x: (UIScreen.main.bounds.width/2/2 - 30),
                             y: -(UIScreen.main.bounds.width/2/2 - 30))
                )
            
            Text(self.title)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width/2 - 15)
    }
    
    var imageWidget: UIImage {
        if self.imageLoader.data.count == 0 {
            return UIImage(imageLiteralResourceName: "default")
        }
        return UIImage(data: self.imageLoader.data)!
    }
    
    func addFavorited(id: String, imageData: Data, keyword: String, owner: String, title: String) {
        let newFavorited = PhotoFavorited(context: self.context)
        newFavorited.id = id
        newFavorited.imageData = imageData
        newFavorited.keyword = keyword
        newFavorited.owner = owner
        newFavorited.title = title
        do {
            try self.context.save()
        } catch {
            print("Error: \(error)")
        }
    }
}

