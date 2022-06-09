//
//  MovieViewModel.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import Foundation

protocol MovieViewModelProtocol {
    func getGenres() -> [Int : String]
    func getMovies(with type: RequestType) -> [MovieModel]
}

final class MovieViewModel: MovieViewModelProtocol {
        
    private lazy var movieGenres: [Int : String] = [:]
    private lazy var nowPlayingMovies: [MovieModel] = []
    private lazy var popularMovies: [MovieModel] = []
    private lazy var upcomingMovies: [MovieModel] = []
    
    func getGenres() -> [Int : String] {
        return movieGenres
    }
    
    func getMovies(with type: RequestType) -> [MovieModel] {
        switch type {
        case .nowPlaying:
            return nowPlayingMovies
        case .popular:
            return popularMovies
        case .upcoming:
            return upcomingMovies
        case .genres:
            return []
        }
    }
    
    func getStringGenres(from list: [Int]) -> [String] {
        var result: [String] = []
        list.forEach {
            result.append(movieGenres[$0] ?? "")
        }
        return result
    }
}

//MARK: - Movie manager delegate methods

extension MovieViewModel: MovieManagerDelegate {
    func didUpdateGenreList(_ viewModel: MovieViewModel, with dict: [Int : String]) {
        viewModel.movieGenres = dict
    }
    
    
    func didUpdateMovieList(_ viewModel: MovieViewModel, with movies: [MovieModel], on type: RequestType) {
        switch type {
        case .genres:
            break
        case .nowPlaying:
            viewModel.nowPlayingMovies = movies
        case .popular:
            viewModel.popularMovies = movies
        case .upcoming:
            viewModel.upcomingMovies = movies
        }
    }
    
    func didFailWithError(error: Error) {
        print("You got following erroу while trying to fetch the data: \(error)")
    }
}
