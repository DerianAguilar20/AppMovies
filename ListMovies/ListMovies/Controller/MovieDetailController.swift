//
//  MovieDetailController.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

protocol showMovieDetailUI: AnyObject {
    func movieDetail(movie: MovieEntity)
}

class MovieDetailController {
    weak var showDetail: showMovieDetailUI?
    private let moveId: String
    let service = MoviesService()
    
    init(movieId id: String) {
        self.moveId = id
    }
    
    func showMovieDetail() {
        let model = service.getMovieDetails(movieId: moveId)
        showDetail?.movieDetail(movie: model)
    }
}
