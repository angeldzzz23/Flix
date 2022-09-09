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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        setUpLayout()
        navigationItem.searchController = searchController

//        tableview.estimatedRowHeight = 180
//        tableview.estimatedRowHeight = UITableView.automaticDimension
        
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
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

