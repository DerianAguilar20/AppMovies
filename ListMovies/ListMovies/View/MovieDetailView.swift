//
//  MovieDetailView.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

import UIKit

class MovieDetailView: UIViewController {
    private let imageMovie: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let nameMovie: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Overview:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
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
        view.backgroundColor = .white
        sizeImage()
        setUpSubViews()
        controller.showMovieDetail()
    }
    
    func setUpSubViews() {
        [nameMovie, imageMovie, subTitle, overview].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            imageMovie.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            imageMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imageMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            imageMovie.heightAnchor.constraint(equalToConstant: 350),
            
            nameMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameMovie.topAnchor.constraint(equalTo: imageMovie.bottomAnchor, constant: 12),
            
            subTitle.topAnchor.constraint(equalTo: nameMovie.bottomAnchor, constant: 20),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            overview.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 12),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        controller.showDetail = self
    }
    
    func sizeImage () {
        let screenSize = UIScreen.main.bounds
        
        if screenSize.width < 400 {
            subTitle.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            nameMovie.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            overview.font = UIFont.systemFont(ofSize: 18, weight: .regular, width: .condensed)
            
        }else {
            subTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            nameMovie.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            overview.font = UIFont.systemFont(ofSize: 23, weight: .regular, width: .condensed)
            
        }
    }
}

extension MovieDetailView: showMovieDetailUI {
    func movieDetail(movie: MovieEntity) {
        DispatchQueue.main.async {
            self.imageMovie.image = UIImage(named: movie.imageName)
            self.nameMovie.text = movie.title
            self.overview.text = movie.overview
        }
    }
}
