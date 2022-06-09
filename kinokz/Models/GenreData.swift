//
//  GenreModel.swift
//  kinokz
//
//  Created by Askar on 07.06.2022.
//

import Foundation

struct GenreData: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
