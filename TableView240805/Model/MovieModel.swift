//
//  MovieModel.swift
//  TableView240805
//
//  Created by Lydia Lu on 2024/8/6.
//

import Foundation

enum MovieType: String, CaseIterable {
    case action = "Action"
    case comedy = "Comedy"
    case drama = "Drama"
    case horror = "Horror"
    case sciFi = "Sci-Fi"
}

struct Movie {
    let title: String
    let type: MovieType
}
