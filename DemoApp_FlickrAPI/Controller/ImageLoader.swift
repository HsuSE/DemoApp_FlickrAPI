//
//  ImageLoader.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/4.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var objectWillChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            objectWillChange.send(data)
        }
    }
    
    init(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
        
    }
}
