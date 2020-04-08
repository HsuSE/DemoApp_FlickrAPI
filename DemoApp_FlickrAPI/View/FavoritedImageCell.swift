//
//  FavoritedImageCell.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/8.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import SwiftUI

struct FavoritedImageCell: View {
    var imageData: Data
    var title: String
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: imageData) ?? UIImage(imageLiteralResourceName: "default"))
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2 - 15 ,
                       height: UIScreen.main.bounds.width/2 - 15 )
                .scaledToFit()
                .clipped()
            
            Text(self.title)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: UIScreen.main.bounds.width/2 - 15)
    }
}


//struct FavoritedImageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritedImageCell()
//    }
//}
