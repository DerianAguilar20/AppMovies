//
//  Mapper.swift
//  AppMovies
//
//  Created by Derian Aguilar on 31/08/23.
//

import Foundation

struct Mapper {
    func map(entity: MovieEntity) -> MovieViewModel{
        MovieViewModel(title: entity.title, imageName: entity.imageName)
    }
}
