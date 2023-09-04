//
//  MovieDetailsRouter.swift
//  AppMovies
//
//  Created by Derian Aguilar on 31/08/23.
//
import UIKit

class MovieDetailsRouter {
    func showMovieDetail(viewControllerReference: UIViewController,
                         movieId id: String) {
        let interator = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter(detailInteractor: interator,
                                              movieId: id,
                                              mapper: MapperDetailMovie())
        let view = MovieDetailsView(presenter: presenter)
        
        presenter.ui = view
        
        viewControllerReference.present(view, animated: true)
    }
}
