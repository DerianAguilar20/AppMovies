//
//  MovieDetailsInteractor.swift
//  AppMovies
//
//  Created by Derian Aguilar on 31/08/23.
//

import Foundation

class MovieDetailsInteractor {
    let moviesList: MovieResponseEntity = MovieResponseEntity(movies: MoviesList)
    
    func getMovieDetails(movieId id: String) async -> MovieEntity {
        return moviesList.movies.first(where: { $0.id == id })!
    }
}
