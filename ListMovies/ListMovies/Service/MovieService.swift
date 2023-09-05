//
//  MovieService.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

class MoviesService {
    let movieRepository = MovieRepository()
    
    func getMoviesList() -> [MovieEntity] {
        return movieRepository.getMovies().movies
    }
    
    func getMovieDetails(movieId id: String) -> MovieEntity {
        return movieRepository.getMovieDetail(movieId: id)
    }
}
