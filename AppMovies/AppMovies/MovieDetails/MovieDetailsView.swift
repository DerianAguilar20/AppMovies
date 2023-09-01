//
//  MovieDetailsView.swift
//  AppMovies
//
//  Created by Derian Aguilar on 31/08/23.
//

import Foundation
import UIKit

class MovieDetailsView: UIViewController {
    private let imageMovie: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let nameMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .left
        label.text = "Overview:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular, width: .condensed)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let presenter: MovieDetailsPresenter
    
    init(presenter: MovieDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageHeight: NSLayoutConstraint?
    var imageWidth: NSLayoutConstraint?
    
    var constraintSmall: [NSLayoutConstraint] = []
    var constraintInicial: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        sizeImage()
        
        constraintInicial = constraintI()
        constraintSmall = constraintS()
        
        [nameMovie, imageMovie, subTitle, overview].forEach(view.addSubview)
        
        activateConstraint()
        presenter.showDetailMovie()
    }
    
    func activateConstraint() {
        let screenSize = UIScreen.main.bounds
        
        if screenSize.width < 400 {
            NSLayoutConstraint.activate(constraintSmall)
        }else {
            NSLayoutConstraint.activate(constraintInicial)
        }
    }
    
    func constraintI() -> [NSLayoutConstraint] {
        return [
            nameMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameMovie.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            nameMovie.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            imageMovie.topAnchor.constraint(equalTo: nameMovie.bottomAnchor, constant: 20),
            imageMovie.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            imageMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imageWidth!,
            imageHeight!,
            
            subTitle.topAnchor.constraint(equalTo: nameMovie.bottomAnchor, constant: 20),
            subTitle.leadingAnchor.constraint(equalTo: imageMovie.trailingAnchor, constant: 5),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            overview.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 12),
            overview.leadingAnchor.constraint(equalTo: imageMovie.trailingAnchor, constant: 5),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ]
    }
    
    func constraintS() -> [NSLayoutConstraint] {
        return [
            nameMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameMovie.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            nameMovie.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            imageMovie.topAnchor.constraint(equalTo: nameMovie.bottomAnchor, constant: 20),
            imageMovie.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            imageMovie.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageWidth!,
            imageHeight!,
            
            subTitle.topAnchor.constraint(equalTo: imageMovie.bottomAnchor, constant: 20),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            overview.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 12),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
    }
    
    
    func sizeImage () {
        let screenSize = UIScreen.main.bounds
        
        if screenSize.width < 400 {
            imageWidth = imageMovie.widthAnchor.constraint(equalToConstant: 175)
            imageHeight = imageMovie.heightAnchor.constraint(equalToConstant: 215)
            subTitle.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            nameMovie.font = UIFont.systemFont(ofSize: 33, weight: .bold)
            overview.font = UIFont.systemFont(ofSize: 18, weight: .regular, width: .condensed)
            
        }else {
            imageHeight = imageMovie.heightAnchor.constraint(equalToConstant: 400)
            imageWidth = imageMovie.widthAnchor.constraint(equalToConstant: 300)
            subTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            nameMovie.font = UIFont.systemFont(ofSize: 36, weight: .bold)
            overview.font = UIFont.systemFont(ofSize: 23, weight: .regular, width: .condensed)
            
        }
    }
}

extension MovieDetailsView: MovieDetailUI {
    func update(detailViewModel: MovieDetailEntity) {
        DispatchQueue.main.async {
            self.nameMovie.text = detailViewModel.title
            self.imageMovie.image = UIImage(named: detailViewModel.imageName)
            self.overview.text = detailViewModel.overview
        }
    }
}
