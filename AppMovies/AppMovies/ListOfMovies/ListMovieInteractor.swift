//
//  ListMovieInteractor.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//

class ListMovieInteractor {
    let movieResponse: MovieResponseEntity = MovieResponseEntity(movies: MoviesList)
    
    func getListMovies() async -> MovieResponseEntity {
        return movieResponse
    }
}
