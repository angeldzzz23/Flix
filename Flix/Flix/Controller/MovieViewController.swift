//
//  ViewController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/6/22.
//

import UIKit


class MovieViewController: UIViewController {
    
    /// MARK: Properies
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private  let searchController = UISearchController(searchResultsController: nil)
    
    private var movies: [Result] = [Result]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUpViews()
        setUpLayout()
        navigationItem.searchController = searchController
        
        MovieController.shared.fetchMovies { result in
            switch result {
            case .success(let moviesss):
                self.updateUI(with: moviesss)
            case .failure(let error):
                print("there was an error")
                self.displayError(error, title: "Failed to fetch movies")
                
            }
        }
    }
    
    
    
    // MARK: layout
    
    /// displays an alert with the specified error (API doesnt work for some reason)
    private func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// updares the tableview
    private func updateUI(with movieItems: [Result]) {
        DispatchQueue.main.async {
            self.movies = movieItems
            self.tableview.reloadData()
        }
    }
    
 
    /// sets up the views
   private func setUpViews() {
        view.backgroundColor = .white
        title = "Now Playing"
        view.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
    }
    

    
    
    
    /// sets up the auto layout
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    
    /// in  charge of configuring the specified cell at indexpath
    func configure(_ cell: MovieTableViewCell, forItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let title = movie.title
        let synopsis = movie.overview
        let posterPath = movie.posterPath
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        // download image
        MovieController.shared.fetchImage(url: posterUrl) { image in
            DispatchQueue.main.async {
                cell.configureImage(image: image ?? UIImage(named: "img")!)
            }
        }
      
        // setting the cell with the properties
        cell.configuretitle(text: title)
        cell.configureSypnosis(text: synopsis)
    }
    
    
}


// conformance to datasource
extension MovieViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    
    
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selecting row at index path")
        let movie = movies[indexPath.row]
        navigationController?.showDetailViewController(MovideDetailViewController(result: movie), sender: true)
    }
}

