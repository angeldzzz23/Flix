//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Angel Zambrano on 9/8/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: properties
    
    static let identifier = "MovieTableViewCell"
    private let imageview = UIImageView() // width = 89
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.text = "Cool"
        titleLbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return titleLbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        lbl.text = "The Red Ribbon Army, an evil organization that was once destroyed by Goku in the past, has been reformed by a group of people who have created new and mightier Androids, Gamma 1 and Gamma 2, and seek vengeance against Goku and his family."
        lbl.textColor = .systemGray
        return lbl
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        setAutoLayout()
    }
    
    
    ///  modifies the visual aspect of the imageView
    
    private func setUp() {
        contentView.addSubview(imageview)
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = .yellow
        
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(descriptionLbl)
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    /// auto layout set up
    private func setAutoLayout() {
        // setting constraints for the image view
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageview.heightAnchor.constraint(equalToConstant: 135),
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageview.widthAnchor.constraint(equalToConstant: 100),
            
        ])
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: imageview.bottomAnchor, constant: 10)
        ])

        // setting constraints for the titleLbl
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 10),
            titleLbl.topAnchor.constraint(equalTo: imageview.topAnchor, constant: 0),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 0),
            descriptionLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor, constant: 0),
            descriptionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: descriptionLbl.bottomAnchor, constant: 10)
        ])

        
    }
    
    
    // MARK: helper functions
    
    /// updates image
    func configureImage(image: UIImage) {
        self.imageview.image = image
    }
    
    /// updates title
    func configuretitle(text: String) {
        self.titleLbl.text = text
    }
    
    /// updates description label
    func configureSypnosis(text: String){
        self.descriptionLbl.text = text
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
