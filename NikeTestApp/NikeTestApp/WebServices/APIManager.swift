//
//  APIManager.swift
//  NikeTestApp
//
//  Created by Harish on 07/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case serverError
    case parsingError
}

class APIManager {
    static let manager = APIManager()
    let session = URLSession.shared
    
    private init() {}
    
    func fetchMusicItems(completionHandler: @escaping (Result<[Music], NetworkError>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/50/explicit.json"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }

        // complicated networking code here
        print("Fetching \(url.absoluteString)...")
        //completionHandler(.success(5))
        session.dataTask(with: url) { (receivedData, receivedResponse, receivedError) in
            if let data = receivedData {
                let decoder = JSONDecoder()
                do {
                    let completeData = try decoder.decode(Feed.self, from: data)
                    completionHandler(.success(completeData.feed.results))
                } catch {
                    completionHandler(.failure(.parsingError))
                }
            } else {
                completionHandler(.failure(.serverError))
            }
        }.resume()
    }
    
    func downloadImage(url: String, completionHandler: @escaping (Result<(Data, String), NetworkError>) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        session.dataTask(with: imageUrl) { (receivedData, receivedResponse, receivedError) in
            if let data = receivedData {
                completionHandler(.success((data, url)))
            } else {
                completionHandler(.failure(.serverError))
            }
        }.resume()
    }
}
