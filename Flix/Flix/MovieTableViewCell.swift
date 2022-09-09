//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Angel Zambrano on 9/8/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: properties
    //
    
    static let identifier = "MovieTableViewCell"
   private let imageview = UIImageView() // width = 89
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .yellow
        setUp()
        setAutoLayout()
            
        
    }
    
    private func setUp() {
        contentView.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = .blue
        contentView.backgroundColor = .red
        
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageview.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
