//
//  MapperDetailMovie.swift
//  AppMovies
//
//  Created by Derian Aguilar on 31/08/23.
//

import Foundation

struct MapperDetailMovie {
    func map(entity: MovieEntity) -> MovieDetailEntity {
        .init(title: entity.title,
                          overview: entity.overview,
                          imageName: entity.imageName)
    }
}
