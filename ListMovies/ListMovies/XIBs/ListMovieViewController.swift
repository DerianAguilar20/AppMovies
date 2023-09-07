//
//  ListMovieViewController.swift
//  ListMovies
//
//  Created by Derian Aguilar on 7/09/23.
//

import UIKit

class ListMovieViewController: UIViewController {

    @IBOutlet weak var reload: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var counter: UILabel!
    
    private let controller = MovieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true

        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        controller.showMovieUI = self
        controller.showMovies()
    }

    @IBAction func reloadMovies(_ sender: Any) {
        activityIndicator.startAnimating()
        counter.text = "Loading movies..."
        tableView.isHidden = true
        activityIndicator.isHidden = false
        controller.clearData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
            self.controller.showMovies()
        }
        
    }
}

extension ListMovieViewController: showMoviesUI, UITableViewDataSource, UITableViewDelegate {
    func moviesUpdate(movies: [MovieEntity]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = controller.movies.count
        self.counter.text = "Movies: \(count)"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let model = controller.movies[indexPath.row]
        
        cell.configure(movie: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.showMovieDetailView(viewControllerReference: self, index: indexPath.row)
    }
}
