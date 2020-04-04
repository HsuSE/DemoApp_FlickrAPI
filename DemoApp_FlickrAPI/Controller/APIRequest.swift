//
//  APIRequest.swift
//  DemoApp_FlickrAPI
//
//  Created by SE Hsu on 2020/4/3.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodeingProblem
}

struct ErrorCode: Codable {
    let stat: String
    let code: Int
    let message: String
}

struct APIRequest {
    let resourceURL: URL
    
    init(text: String, per_page: Int) {
        let resourceString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=ae2fd72ac6bfa4df78d753232db28342&text=\(text)&per_page=\(per_page)&format=json&nojsoncallback=1"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }

        self.resourceURL = resourceURL
    }
    
    func search(page: Int, completion: @escaping(Result<[PhotoDetail], APIError>) -> ()) {
        let urlPage = URL(string: "\(self.resourceURL.absoluteString)&page=\(page)")!
        var urlRequest = URLRequest(url: urlPage)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else {
                    return completion(.failure(.responseProblem))
            }
            
            let decoder = JSONDecoder()
            if let searchData = try? decoder.decode(FlickrData.self, from: jsonData) {
                completion(.success(searchData.photos.photo))
            } else if let errorData = try? decoder.decode(ErrorCode.self, from: jsonData), errorData.code == 112  {
                print(errorData.message)
                completion(.failure(.responseProblem))
            } else {
                completion(.failure(.decodeingProblem))
            }
            
        }.resume()
    }
    
}
