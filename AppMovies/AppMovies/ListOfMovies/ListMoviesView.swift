//
//  ListMoviesView.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//
import UIKit

class ListMovieView: UIViewController {
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
        configure.image = UIImage(named: "reload")
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
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .white
        
        return stack
    }()
    
    private var movieTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 20
        table.rowHeight = UITableView.automaticDimension
        table.register(TableCustomCell.self, forCellReuseIdentifier: "TableCustomCell")
        
        return table
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    private let presenter: ListMoviePresenter
    
    init(presenter: ListMoviePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        movieTable.isHidden = false
        activityIndicator.isHidden = true
        setUpTable()
        presenter.showMovies()
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
        
        movieTable.dataSource = self
        movieTable.delegate = self
        
        stackView.addArrangedSubview(counter)
        stackView.addArrangedSubview(refresh)
    }
    
    func addRefresh() {
        activityIndicator.startAnimating()
        counter.text = "Loading movies..."
        movieTable.isHidden = true
        activityIndicator.isHidden = false
        presenter.clearData()
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.activityIndicator.isHidden = true
            self.movieTable.isHidden = false
            self.activityIndicator.stopAnimating()
            self.presenter.showMovies()
        }
    }
}

extension ListMovieView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = String(presenter.movieViewModels.count)
        counter.text = "Movies: \(count)"
        
        let cell = movieTable.dequeueReusableCell(withIdentifier: "TableCustomCell", for: indexPath) as! TableCustomCell
    
        let model = presenter.movieViewModels[indexPath.row]
        
        cell.configureCell(model: model)
        
        return cell
    }
}

extension ListMovieView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showMovieDeil(index: indexPath.row)
    }
}

extension ListMovieView: ListMoviesUI {
    func update(movies: [MovieViewModel]) {
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }
}
