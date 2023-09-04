//
//  ListMovieCustomCell.swift
//  AppMovies
//
//  Created by Derian Aguilar on 4/09/23.
//
import UIKit

class TableCustomCell: UITableViewCell {
    
    let poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let movieTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 20,
                                       weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.textColor = .white
        
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        
        addSubview(poster)
        addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: topAnchor),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: trailingAnchor),
            poster.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            poster.heightAnchor.constraint(equalToConstant: 375),
            
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configureCell(model: MovieViewModel) {
        poster.image = UIImage(named: model.imageName)
        movieTitle.text = model.title
    }
}
