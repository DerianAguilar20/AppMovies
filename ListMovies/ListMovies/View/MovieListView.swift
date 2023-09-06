//
//  ViewController.swift
//  ListMovies
//
//  Created by Derian Aguilar on 5/09/23.
//

import UIKit

class ViewController: UIViewController {
    private let counter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var refresh: UIButton = {
        var configure = UIButton.Configuration.borderless()
        configure.buttonSize = .medium
        configure.title = "Refresh"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: {
            [weak self] _ in self?.addRefresh()
        }))
        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .white
        
        return stack
    }()
    
    private var movieTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 10
        table.rowHeight = UITableView.automaticDimension
        table.register(MovieCustomCell.self, forCellReuseIdentifier: "MovieCustomCell")
        
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    let controller = MovieController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activityIndicator.isHidden = true
        setUpTable()
        controller.showMovies()
    }
    
    func setUpTable(){
        [stackView, movieTable, activityIndicator].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            
            movieTable.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            movieTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: movieTable.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: movieTable.centerYAnchor)
        ])
        
        stackView.addArrangedSubview(counter)
        stackView.addArrangedSubview(refresh)
        
        controller.showMovieUI = self
        
        movieTable.dataSource = self
        movieTable.delegate = self
    }
    
    func addRefresh() {
        activityIndicator.startAnimating()
        counter.text = "Loading movies..."
        movieTable.isHidden = true
        activityIndicator.isHidden = false
        controller.clearData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.movieTable.isHidden = false
            self.controller.showMovies()
        }
    }
}

extension ViewController: showMoviesUI {
    func moviesUpdate(movies: [MovieEntity]) {
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = String(controller.movies.count)
        counter.text = "Movies: \(count)"
        
        let cell = movieTable.dequeueReusableCell(withIdentifier: "MovieCustomCell", for: indexPath) as! MovieCustomCell
        
        let model = controller.movies[indexPath.row]
        
        cell.configureCell(model: model)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.showMovieDetailView(viewControllerReference: self, index: indexPath.row)
    }
}
