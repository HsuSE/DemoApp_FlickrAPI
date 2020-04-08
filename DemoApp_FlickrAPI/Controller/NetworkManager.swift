//
//  CollectionViewController.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/4.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var objectWillChange = PassthroughSubject<NetworkManager, Never>()
    var page = 1
    var searchResult: APIRequest
    var photos = [PhotoDetail]() {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    init(text: String, per_page: Int) {
        searchResult = APIRequest(text: text, per_page: per_page)
     }
    
    func fatch() {
        searchResult.search(page: self.page) { result in
            switch result {
            case .success(let photoDetail):
                self.photos += photoDetail
            case .failure(.decodeingProblem):
                print("Decode Error!")
            case .failure(.responseProblem):
                print("Response Error")
            }
        }
        self.page += 1
    }
    
    func coupleItem() -> [[PhotoDetail]] {
        var coupleitem = [[PhotoDetail]]()
        for idx in stride(from: 0, to: photos.count, by: 2) {
            if idx+1 == photos.count {
                coupleitem += [[photos[idx]]]
                break
            }
            coupleitem += [[photos[idx], photos[idx+1]]]
        }
        return coupleitem
    }
}
