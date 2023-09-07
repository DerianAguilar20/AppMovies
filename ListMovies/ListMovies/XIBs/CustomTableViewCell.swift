//
//  CustomTableViewCell.swift
//  ListMovies
//
//  Created by Derian Aguilar on 7/09/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    static let identifier = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    func configure(movie: MovieEntity) {
        self.imageMovie.image = UIImage(named: movie.imageName)
        self.titleMovie.text = movie.title
    }
    
}
