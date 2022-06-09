//
//  GenreModel.swift
//  kinokz
//
//  Created by Askar on 07.06.2022.
//

import Foundation

struct MovieModel {
    var movieViewModel: MovieViewModel?
    var genreNames: [String]
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    init(movieViewModel: MovieViewModel, genreIds: [Int], id: Int, overview: String, posterPath: String, releaseDate: String, title: String, voteAverage: Double, voteCount: Int) {
        self.movieViewModel = movieViewModel
        self.genreNames = movieViewModel.getStringGenres(from: genreIds)
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
