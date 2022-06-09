//
//  Constants.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import Foundation
import UIKit

struct Constants {
    
    struct Identifiers {
        static let sectionTableViewCell = "SectionTableViewCell"
        static let movieCollectionViewCell = "MovieCollectionViewCell"
    }
    
    struct Colors {
        
    }
    
    struct Values {
        static let sectionTableViewCellHeight: CGFloat = 250
        static let movieCollectionViewCellWidth: CGFloat = sectionTableViewCellHeight / 2.25
        static let mainTitle = "Фильмы"
        static let enumNowPlayingTitle = "Сегодня в кино"
    }
    
    struct Icons {
        static let location = "mappin.circle"
    }
    
    struct Keys {
        static let API = "b546d4933841b9453fa9ccabe482d1a8"
    }
    
    struct Links {
        static let genresUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Keys.API)&language=ru-RU"
        static let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(Keys.API)&language=ru-RU&page=1&region=ru"
        static let popularUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(Keys.API)&language=ru-RU&page=1&region=ru"
        static let upcomingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Keys.API)&language=ru-RU&page=1&region=ru"
        static let imageUrl = "https://image.tmdb.org/t/p/w500/"
    }
}
