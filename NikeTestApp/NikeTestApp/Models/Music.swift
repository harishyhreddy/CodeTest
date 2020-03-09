//
//  Music.swift
//  NikeTestApp
//
//  Created by Harish on 07/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import Foundation

struct Music: Codable {
    let id: String
    let name: String
    let artistName: String
    let url: String
    let artworkUrl100: String
    let genres: [Genere]
    let releaseDate: String
    let copyright: String
}
