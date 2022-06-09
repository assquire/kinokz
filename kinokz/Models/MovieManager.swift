//
//  MovieManager.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import Foundation

protocol MovieManagerDelegate: AnyObject {
    func didUpdateGenreList(_ viewModel: MovieViewModel, with dict: [Int:String])
    func didUpdateMovieList(_ viewModel: MovieViewModel, with movies: [MovieModel], on type: RequestType)
    func didFailWithError(error: Error)
}

enum RequestType: String, CaseIterable {
    case genres = "Жанры"
    case nowPlaying = "Сегодня в кино"
    case popular = "Популярное"
    case upcoming = "Скоро в кино"
}

struct MovieManager {
    
    weak var delegate: MovieManagerDelegate?
    weak var viewModel: MovieViewModel?
    
    func fetchContent(with type: RequestType) {
        var urlString = ""
        switch type {
        case .genres:
            urlString = Constants.Links.genresUrl
        case .nowPlaying:
            urlString = Constants.Links.nowPlayingUrl
        case .popular:
            urlString = Constants.Links.popularUrl
        case .upcoming:
            urlString = Constants.Links.upcomingUrl
        }
        performRequest(with: urlString, requestType: type)
    }
    
    func performRequest(with urlString: String, requestType type: RequestType) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    guard let safeViewModel = viewModel else { return }
                    switch type {
                    case .genres:
                        if let genres = self.parseGenreJSON(safeData) {
                            delegate?.didUpdateGenreList(safeViewModel, with: genres)
                        }
                    default:
                        if let movies = self.parseMoviesJSON(safeData) {
                            delegate?.didUpdateMovieList(safeViewModel, with: movies, on: type)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseGenreJSON(_ data: Data) -> [Int:String]? {
        let decoder = JSONDecoder()
        var dict: [Int:String] = [:]
        do {
            let decodedData = try decoder.decode(GenreData.self, from: data)
            for i in 0..<decodedData.genres.count {
                let id = decodedData.genres[i].id
                let name = decodedData.genres[i].name
                dict[id] = name
            }
            return dict
        } catch {
            print(error)
            return nil
        }
    }
    
    func parseMoviesJSON(_ data: Data) -> [MovieModel]? {
        guard let safeViewModel = viewModel else { fatalError() }
        var movieList: [MovieModel] = []
        do {
            let decodedData = try JSONDecoder().decode(MovieData.self, from: data)
            for i in 0..<decodedData.results.count {
                let movie = decodedData.results[i]
                let genreIds = movie.genre_ids
                let id = movie.id
                let overview = movie.overview
                let posterPath = movie.poster_path
                let releaseDate = movie.release_date
                let title = movie.title
                let voteAverage = movie.vote_average
                let voteCount = movie.vote_count
                let movieModel = MovieModel(movieViewModel: safeViewModel, genreIds: genreIds, id: id, overview: overview, posterPath: posterPath, releaseDate: releaseDate, title: title, voteAverage: voteAverage, voteCount: voteCount)
                movieList.append(movieModel)
            }
            return movieList
        } catch {
            print(error)
            return nil
        }
    }
}
