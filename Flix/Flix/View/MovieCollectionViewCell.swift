//
//  MovieCollectionViewCell.swift
//  Flix
//
//  Created by Angel Zambrano on 9/19/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    let movieImageView: UIImageView = {
        let imgviww = UIImageView()
        imgviww.contentMode = .scaleToFill
        
        imgviww.translatesAutoresizingMaskIntoConstraints = false

        return imgviww
    }()
    
    
    func setImage(image: UIImage) {
        self.movieImageView.image = image
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame) // adds the frame into the super view

        setUPViews()
        setUpConstraints()
    }
    
    private func setUPViews() {
        contentView.addSubview(movieImageView)
    }
    
    
    private func setUpConstraints() {
        movieImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


