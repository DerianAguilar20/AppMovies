//
//  MovieResponseEntity.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

struct MovieResponseEntity: Decodable {
    let movies: [MovieEntity]
}
