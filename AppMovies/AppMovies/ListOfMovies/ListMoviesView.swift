//
//  ListMoviesView.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//

import Foundation
import UIKit

class ListMovieView: UIViewController {
    private let counter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var reload: UIButton = {
        var configure = UIButton.Configuration.filled()
        configure.image = UIImage(named: "reload")
        configure.buttonSize = .medium
        configure.baseBackgroundColor = .white
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: {
            [weak self] _ in self?.reloadView()
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
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = UIColor(red: 123.0/255.0, green: 36.0/255.0, blue: 28.0/255.0, alpha: 1)
        
        return stack
    }()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 300, height: 320)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let screenSize = UIScreen.main.bounds
        if screenSize.width < 400 {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }else {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 90, bottom: 20, right: 90)
        }
        

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(collectionCustomCell.self, forCellWithReuseIdentifier: "ListMovieCollectionCustomCell")
        
        return collection
    }()
    
    private let presenter: ListMoviePresenter
    
    init(presenter: ListMoviePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    var stackHeight: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        sizeScreen()
        setUpTable()
        presenter.showMovies()
    }
    
    func setUpTable(){
        [stackView, collectionView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackHeight!,
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(counter)
        stackView.addArrangedSubview(reload)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadView() {
        
        let refreshViewController = RefreshViewController()
        view.addSubview(refreshViewController.view)
        addChild(refreshViewController)
        refreshViewController.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            refreshViewController.willMove(toParent: nil)
            refreshViewController.removeFromParent()
            refreshViewController.view.removeFromSuperview()
        }
        
    }
    
    func sizeScreen() {
        let screenSize = UIScreen.main.bounds
        
        if screenSize.width > 400 {
            counter.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            reload.configuration?.buttonSize = .large
            stackHeight = stackView.heightAnchor.constraint(equalToConstant: 50)
        }else {
            stackHeight = stackView.heightAnchor.constraint(equalToConstant: 44)
        }
    }
}

extension ListMovieView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.movieViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListMovieCollectionCustomCell", for: indexPath) as! collectionCustomCell
        
        let model = presenter.movieViewModels[indexPath.row]
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 10).cgPath
        
        cell.configure(model: model)
        
        return cell
    }
}

extension ListMovieView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showMovieDeil(index: indexPath.row)
    }
}

extension ListMovieView: ListMoviesUI {
    func update(movies: [MovieViewModel]) {
        DispatchQueue.main.async {
            let count = String(movies.count)
            self.collectionView.reloadData()
            self.counter.text = "Count: \(count)"
        }
    }
}
