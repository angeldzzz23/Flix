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
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.text = "Luca"
        titleLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return titleLbl
    }()
    
    
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    
    func configureImage(image: UIImage) {
        self.imageview.image = image
    }
    
    func configuretitle(text: String) {
        self.titleLbl.text = text
    }
    
    
    
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
        
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setAutoLayout() {
        // setting constraints for the image view
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageview.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        // setting constraints for the titleLbl
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 10),
            titleLbl.topAnchor.constraint(equalTo: imageview.topAnchor, constant: 0),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
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
