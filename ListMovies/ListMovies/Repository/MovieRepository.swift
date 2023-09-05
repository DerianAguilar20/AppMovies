//
//  MovieRepository.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

class MovieRepository {
    func getMovies() -> MovieResponseEntity {
        return MovieResponseEntity(movies: ListMoviesData)
    }
    
    func getMovieDetail(movieId id: String) -> MovieEntity {
        return ListMoviesData.first(where: { $0.id == id })!
    }
}
