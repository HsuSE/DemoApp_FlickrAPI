//
//  FavoritedImageCell.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/8.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI

struct FavoritedImageCell: View {
    var image: UIImage
    var title: String
    init(title:String, imageData: Data?) {
        if let imageData = imageData {
            self.image = UIImage(data: imageData)!
        } else {
            self.image = UIImage(imageLiteralResourceName: "default")
        }
        self.title = title
    }
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2 - 15 ,
                       height: UIScreen.main.bounds.width/2 - 15 )
                .scaledToFit()
                .clipped()
            
            Text(title)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width/2 - 15)
    }
}

