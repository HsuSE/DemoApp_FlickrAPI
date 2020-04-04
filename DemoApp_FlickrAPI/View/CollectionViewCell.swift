//
//  CollectionViewCell.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/4.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI
import Combine


struct CollectionViewCell: View {
    @ObservedObject var imageLoader: ImageLoader
    var title: String
    
    init (title: String, imageURL: URL) {
        self.title = title
        imageLoader = ImageLoader(imageURL: imageURL)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: imageWidget)
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2 - 15,
                       height: UIScreen.main.bounds.width/2 - 15)
                .scaledToFill()
                .clipped()
            
            Text(self.title)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width/2 - 10)
    }
    
    var imageWidget: UIImage {
        if self.imageLoader.data.count == 0 {
           return UIImage(imageLiteralResourceName: "default")
        }
        return UIImage(data: self.imageLoader.data)!
    }
}

struct CollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewCell(title: "test", imageURL: URL(string: "https://farm66.staticflickr.com/65535/49730675053_ea03f50af5_s.jpg")!)
        .previewLayout(
        .fixed(width: UIScreen.main.bounds.width/2 - 18, height: UIScreen.main.bounds.height/4))
    }
}
