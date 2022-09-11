//
//  ViewController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/6/22.
//

import UIKit

final class AutoSizingTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        return contentSize
    }
}




class ViewController: UIViewController {

//    let searchView = UISearchBar()

    

    
    let tableview: AutoSizingTableView = {
        let tableview = AutoSizingTableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    let searchController = UISearchController(searchResultsController: nil)
    
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        setUpLayout()
        navigationItem.searchController = searchController

//        tableview.estimatedRowHeight = 180
//        tableview.estimatedRowHeight = UITableView.automaticDimension
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
              let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
              let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
              let task = session.dataTask(with: request) { data, _, error in
                  // This will run when the network request returns
                  if let error = error {
                      print(error)
                  } else if let data = data {
                      let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                      self.movies = dataDictionary["results"] as! [[String: Any]]
                      
                      
                      // Call tableView functions again
                      self.tableview.reloadData()
                  }
              }
              task.resume()
        
        
    }
    
    // MARK: layout
    
    /// sets up the views
   private func setUpViews() {
        view.backgroundColor = .white
        title = "Now Playing"
        
//        searchView.delegate = self
//        view.addSubview(searchView)
        
       
        
        view.addSubview(tableview)

        tableview.dataSource = self
        tableview.delegate = self
        
    }
    
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    
    /// sets up the auto layout
    private func setUpLayout() {
        
        // setting up the contrains for the search view
//        searchView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
//
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

}


//extension ViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//
//    }
//}

// conformance to datasource
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        
        fetchImage(url: posterUrl) { image in
            DispatchQueue.main.async {
                cell.configureImage(image: image ?? UIImage(named: "img")!)
            }
            
        }
        
        cell.configuretitle(text: title)
        cell.configureSypnosis(text: synopsis)
    

        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

//
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

