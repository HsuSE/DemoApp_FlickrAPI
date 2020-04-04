//
//  Images.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/2.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import Foundation
import SwiftUI

struct FlickrData: Decodable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [PhotoDetail]
}

struct PhotoDetail: Codable, Hashable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int

    var imageURL: URL {
        return URL(string: "https://farm\(self.farm).staticflickr.com/\(self.server)/\(self.id)_\(self.secret)_s.jpg")!
    }
}



