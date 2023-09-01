//
//  MovieDetailsPresenter.swift
//  AppMovies
//
//  Created by Derian Aguilar on 31/08/23.
//

import Foundation

protocol MovieDetailUI: AnyObject {
    func update(detailViewModel: MovieDetailEntity)
}

class MovieDetailsPresenter {
    weak var ui: MovieDetailUI?
    
    private let movieId: String
    private let detailInteractor: MovieDetailsInteractor
    private let mapper: MapperDetailMovie
    
    init(detailInteractor: MovieDetailsInteractor, movieId: String, mapper: MapperDetailMovie) {
        self.detailInteractor = detailInteractor
        self.movieId = movieId
        self.mapper = mapper
    }
    
    func showDetailMovie() {
        Task {
            let model = await detailInteractor.getMovieDetails(movieId: movieId)
            let detailViewModel = mapper.map(entity: model)
            await MainActor.run {
                self.ui?.update(detailViewModel: detailViewModel)
            }
        }
    }
    
}
