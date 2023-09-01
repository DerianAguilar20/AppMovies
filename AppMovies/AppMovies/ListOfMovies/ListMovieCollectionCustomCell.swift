//
//  ListMovieCollectionCustomCell.swift
//  AppMovies
//
//  Created by Derian Aguilar on 1/09/23.
//

import Foundation
import UIKit

class collectionCustomCell: UICollectionViewCell {
    
    let poster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let movieTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 26,
                                       weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        
        addSubview(poster)
        addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            poster.centerXAnchor.constraint(equalTo: centerXAnchor),
            poster.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            poster.heightAnchor.constraint(equalToConstant: 200),
            poster.widthAnchor.constraint(equalToConstant: 150),
            poster.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
            
            movieTitle.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 12),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            movieTitle.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configure(model: MovieViewModel) {
        poster.image = UIImage(named: model.imageName)
        movieTitle.text = model.title
    }
}
