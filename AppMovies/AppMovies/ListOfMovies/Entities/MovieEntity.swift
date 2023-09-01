//
//  MovieEntity.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//

import Foundation

struct MovieEntity: Decodable {
    var id: String
    var title: String
    var overview: String
    var imageName: String
}
