//
//  MovieEntity.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

struct MovieEntity: Decodable {
    var id: String
    var title: String
    var overview: String
    var imageName: String
}
