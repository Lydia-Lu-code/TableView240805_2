//
//  MoviesViewModel.swift
//  TableView240805
//
//  Created by Lydia Lu on 2024/8/6.
//
import Foundation

class MoviesViewModel {
    private let movies: [Movie] = [
        Movie(title: "Spider-Man", type: .action),
        Movie(title: "Iron Man", type: .action),
        Movie(title: "The Avengers", type: .action),
        Movie(title: "Black Panther", type: .action),
        Movie(title: "Guardians of the Galaxy", type: .action),
        Movie(title: "The Hangover", type: .comedy),
        Movie(title: "Superbad", type: .comedy),
        Movie(title: "Step Brothers", type: .comedy),
        Movie(title: "Bridesmaids", type: .comedy),
        Movie(title: "21 Jump Street", type: .comedy),
        Movie(title: "The Shawshank Redemption", type: .drama),
        Movie(title: "Forrest Gump", type: .drama),
        Movie(title: "The Godfather", type: .drama),
        Movie(title: "Fight Club", type: .drama),
        Movie(title: "The Green Mile", type: .drama),
        Movie(title: "The Conjuring", type: .horror),
        Movie(title: "Get Out", type: .horror),
        Movie(title: "A Quiet Place", type: .horror),
        Movie(title: "It", type: .horror),
        Movie(title: "Hereditary", type: .horror),
        Movie(title: "Inception", type: .sciFi),
        Movie(title: "The Matrix", type: .sciFi),
        Movie(title: "Interstellar", type: .sciFi),
        Movie(title: "Blade Runner 2049", type: .sciFi),
        Movie(title: "Arrival", type: .sciFi)
    ]
    
    func movies(for type: MovieType) -> [Movie] {
        return movies.filter { $0.type == type }
    }
    
    func allMovies() -> [Movie] {
        return movies
    }
}
