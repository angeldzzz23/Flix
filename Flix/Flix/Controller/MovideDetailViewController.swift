//
//  MovideDetailViewController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/16/22.
//

import UIKit

class MovideDetailViewController: UIViewController {

    let backgroundimageview: UIImageView = {
        let imgviww = UIImageView()
        
        imgviww.translatesAutoresizingMaskIntoConstraints = false

        return imgviww
    }()
    
    let movieImage: UIImageView = {
        let imgviww = UIImageView()
        
        imgviww.translatesAutoresizingMaskIntoConstraints = false
        return imgviww
    }()
    let movieName: UILabel = {
        let lbl = UILabel()
        lbl.text = "mortal combat"
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let movieYear: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let movieDescription: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.text = "2021-04-07jsqn  jqnskjqnskj qnksjq  nskj    qnksq   nksj    qnkjs   qnkjs   qnkjs   nqjksn  qkjsqnkjs   nqkjsq  nkjsnq  ksnq    kjsn    qkjsnq  kjsn    qkjsnqjksnqkj   snjkqnk sjqskn  jdhjfhdjsq  lkjhdqkjsanjkdxanskjfnaskfjnsakjfnskj nkj j fanjksn kj"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        addSubviews()
        addConstraints()
    }
    
    // MARK: init
    
    init(result: Result) {
        super.init(nibName: nil, bundle: nil)
        
        setUpData(result: result)

       
 
    }
    
    private func setUpData(result: Result) {
        movieName.text = result.title
        movieYear.text =  result.releaseDate
        movieDescription.text = result.overview
        
        let posterPath = result.posterPath
     
            
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        // set image
        MovieController.shared.fetchImage(url: posterUrl) { image in
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
        
        let poster2 = URL(string: baseUrl + result.backdropPath)!
        
        MovieController.shared.fetchImage(url: poster2) { image in
            DispatchQueue.main.async {
                self.backgroundimageview.image = image
            }
        }
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        view.addSubview(backgroundimageview)
        view.addSubview(movieImage)
        view.addSubview(movieName)
        view.addSubview(movieYear)
        view.addSubview(movieDescription)
        view.backgroundColor = .black
        
        
    }
    
    
    
    private func addConstraints() {
        backgroundimageview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        backgroundimageview.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        
        movieImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top:view.frame.height/3 * 0.7, left: 20, bottom: 0, right: 0), size: .init(width: 120, height: 200))

        
        movieName.anchor(top: backgroundimageview.bottomAnchor, leading: movieImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        movieYear.anchor(top: movieName.bottomAnchor, leading: movieName.leadingAnchor, bottom: nil, trailing: movieName.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        movieDescription.anchor(top: movieImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    

}
