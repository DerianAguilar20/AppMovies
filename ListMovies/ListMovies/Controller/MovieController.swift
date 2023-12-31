//
//  MovieController.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

import UIKit

protocol showMoviesUI: AnyObject {
    func moviesUpdate(movies: [MovieEntity])
}

class MovieController {
    weak var showMovieUI: showMoviesUI?
    
    let service = MoviesService()
    var movies: [MovieEntity] = []
    
    func showMovies() {
        movies = service.getMoviesList()
        showMovieUI?.moviesUpdate(movies: movies)
    }
    
    func showMovieDetailView(viewControllerReference: UIViewController, index: Int) {
        let movieID = movies[index].id
        let controller = MovieDetailController(movieId: movieID)
        let view = DetailMovieViewController(controller: controller)
        viewControllerReference.present(view, animated: true)
    }
    
    func clearData() {
        movies = []
        showMovieUI?.moviesUpdate(movies: movies)
    }
}
