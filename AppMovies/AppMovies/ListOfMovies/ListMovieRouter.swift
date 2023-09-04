//
//  ListMovieRouter.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//
import UIKit

class ListMovieRouter {
    var movieDetailRouter: MovieDetailsRouter?
    var listMoviesView: ListMovieView?
    
    func showListMovies(window: UIWindow?){
        self.movieDetailRouter = MovieDetailsRouter()
        let interactor = ListMovieInteractor()
        let presenter = ListMoviePresenter(listMovieInteractor: interactor, listMovieRouter: self)
        
        listMoviesView = ListMovieView(presenter: presenter)
        
        presenter.ui = listMoviesView
        
        window?.rootViewController = listMoviesView
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetail(movieId id: String) {
        guard let view = listMoviesView else {
            return
        }
        
        movieDetailRouter?.showMovieDetail(viewControllerReference: view, movieId: id)
    }
}
