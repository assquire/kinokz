//
//  MovieModel.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import Foundation

struct MovieData: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let genre_ids: [Int]
    let id: Int
    let overview: String
    let poster_path: String
    let release_date: String
    let title: String
    let vote_average: Double
    let vote_count: Int
}
