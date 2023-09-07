//
//  DetailMovieViewController.swift
//  ListMovies
//
//  Created by Derian Aguilar on 7/09/23.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    private let controller: MovieDetailController
    
    init(controller: MovieDetailController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.showDetail = self
        
        controller.showMovieDetail()
    }
}

extension DetailMovieViewController: showMovieDetailUI {
    func movieDetail(movie: MovieEntity) {
        DispatchQueue.main.async {
            self.imageMovie.image = UIImage(named: movie.imageName)
            self.nameMovie.text = movie.title
            self.overview.text = movie.overview
        }
    }
}
