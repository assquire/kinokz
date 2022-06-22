//
//  MovieViewModel.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import Foundation

protocol MovieViewModelDelegate {
    func didUpdateViewModel(_ viewModel: MovieViewModel)
}

protocol MovieViewModelProtocol {
    func getGenres() -> [Int : String]
    func getMovies(with type: RequestType) -> [MovieModel]
}

final class MovieViewModel: MovieViewModelProtocol {
            
    var movieManager = MovieManager()
    var delegate: MovieViewModelDelegate?
    
    private lazy var movieGenres: [Int : String] = [:]
    private lazy var nowPlayingMovies: [MovieModel] = []
    private lazy var popularMovies: [MovieModel] = []
    private lazy var upcomingMovies: [MovieModel] = []
    
    init() {
        movieManager.delegate = self
        movieManager.viewModel = self
    }
    
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
    
    func fetchAll() {
        RequestType.allCases.forEach {
            movieManager.fetchContent(with: $0)
            delegate?.didUpdateViewModel(self)
        }
    }
}

//MARK: - Movie manager delegate methods

extension MovieViewModel: MovieManagerDelegate {
    func didUpdateGenreList(with dict: [Int : String]) {
        movieGenres = dict
    }
    
    
    func didUpdateMovieList(with movies: [MovieModel], on type: RequestType) {
        switch type {
        case .nowPlaying:
            nowPlayingMovies = movies
        case .popular:
            popularMovies = movies
        case .upcoming:
            upcomingMovies = movies
        default: return
        }
    }
    
    func didFailWithError(error: Error) {
        print("You got following error while trying to fetch the data: \(error)")
    }
}
