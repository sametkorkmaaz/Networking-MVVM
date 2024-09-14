//
//  MovieModel.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import Foundation

// MARK: - Welcome
struct MovieModel: Codable {
    let title, description: String?
    let movies: [Movie]?
}

// MARK: - Movie
struct Movie: Codable {
    let id, title, releaseYear: String?
}
