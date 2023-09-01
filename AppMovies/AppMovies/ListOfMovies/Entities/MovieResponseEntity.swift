//
//  MovieResponseEntity.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//

import Foundation

struct MovieResponseEntity: Decodable {
    let movies: [MovieEntity]
}
