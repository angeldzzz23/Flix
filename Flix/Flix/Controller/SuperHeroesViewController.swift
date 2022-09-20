//
//  SuperHeroesViewController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/19/22.
//

import UIKit

// this will contain a collectionview cell
class SuperHeroesViewController: UIViewController {
    
    private var filtCollectionView: UICollectionView! // the filter collection view
    
      private let pCellPadding:CGFloat = 5
      
    private let peopleCellReuseIdentifier = "peopleCellReuseIdentifier"
    
    private var movies: [SuperHeroResult] = [SuperHeroResult]()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "superheros"
        
        let peopleLayout = UICollectionViewFlowLayout()
            peopleLayout.scrollDirection = .vertical
            peopleLayout.minimumInteritemSpacing = pCellPadding
            peopleLayout.minimumLineSpacing = pCellPadding
            peopleLayout.sectionInset = UIEdgeInsets(top: pCellPadding, left: 0, bottom: pCellPadding, right: 0)
        
        filtCollectionView = UICollectionView(frame: .zero, collectionViewLayout: peopleLayout)
        filtCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtCollectionView.backgroundColor = .clear

        // Do any additional setup after loading the view.
        
        filtCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
//        filtCollectionView.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier: peopleCellReuseIdentifier)

        view.addSubview(filtCollectionView)

        
//        filtCollectionView.backgroundColor = .red
        
        
        
        filtCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        filtCollectionView.dataSource = self
        filtCollectionView.delegate = self
        
        
    
            MovieController.shared.fetchSuperHeroMovies { result in
                switch result {
                case .success(let moviesss):
                    
                    self.updateUI(with: moviesss)
                case .failure(let error):
                    print("there was an error")
                    self.displayError(error, title: "Failed to fetch movies")
                    
                }
            }
        
        
        
    }
    
    private func updateUI(with movieItems: [SuperHeroResult]) {
        DispatchQueue.main.async {
            self.movies = movieItems
            self.filtCollectionView.reloadData()
        }
    }
    
    
    private func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
   private func configure(_ cell: MovieCollectionViewCell, forItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie.posterPath
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        // download image
        MovieController.shared.fetchImage(url: posterUrl) { image in
            DispatchQueue.main.async {

                cell.setImage(image: image!)
            }
        }
      
        // setting the cell with the properties
        
        
    }
    

}

extension SuperHeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        configure(cell, forItemAt: indexPath)
        
        return cell

    }
    
}

extension SuperHeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (pCellPadding) ) / 2
        return .init(width: size, height: size + (size * 0.275))
    }
}

