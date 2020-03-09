//
//  CacheManager.swift
//  NikeTestApp
//
//  Created by Harish on 08/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import Foundation

class CacheManager {
    static let manager = CacheManager()
    let cache = NSCache<NSString, NSData>()
    private init() {}
    
    func fetch(from imageUrl: String) -> Data? {
        return cache.object(forKey: imageUrl as NSString) as Data?
    }
    
    func cahceImage(url: String, data: Data) {
        cache.setObject(data as NSData, forKey: url as NSString)
    }
}
