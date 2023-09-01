//
//  ListMovieViewPresenter.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//

import Foundation

protocol ListMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

class ListMoviePresenter {
    weak var ui: ListMoviesUI?
    
    private let listMovieInteractor: ListMovieInteractor
    var movieViewModels: [MovieViewModel] = []
    private var movieEntityList: [MovieEntity] = []
    private let mapper: Mapper
    private let listMovieRouter: ListMovieRouter
    
    init(listMovieInteractor: ListMovieInteractor, mapper: Mapper = Mapper(), listMovieRouter: ListMovieRouter) {
        self.listMovieInteractor = listMovieInteractor
        self.mapper = mapper
        self.listMovieRouter = listMovieRouter
    }
    
    func showMovies(){
        Task {
            movieEntityList = await listMovieInteractor.getListMovies().movies
            movieViewModels = movieEntityList.map(mapper.map(entity:))
            ui?.update(movies: movieViewModels)
        }
    }
    
    func showMovieDeil(index: Int) {
        let movieId = movieEntityList[index].id
        listMovieRouter.showMovieDetail(movieId: movieId)
    }
}
