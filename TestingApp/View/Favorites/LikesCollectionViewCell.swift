//
//  LikesCollectionViewCell.swift
//  TestingApp
//
//  Created by мак on 05.09.2022.
//

import Foundation
import UIKit
import SDWebImage

class LikesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "LikesCollectionViewCell"
    
    var myImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        return imageView
    }()
    
    var regularImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["thumb"]
            let photoUrlRegular = unsplashPhoto.urls["regular"]

            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            guard let imageUrlRegular = photoUrlRegular, let urlRegular = URL(string: imageUrlRegular) else { return }

            myImageView.sd_setImage(with: url, completed: nil)
            regularImageView.sd_setImage(with: urlRegular, completed: nil)
        }
    }
    
     var authorLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .right
         label.sizeToFit()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 15, weight: .light)
         label.textColor = .white
         label.backgroundColor = .black
         label.alpha = 0.5
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .green
        
        setupImageView()
        setupLabel()
    }
    
    func setupImageView() {
        addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupLabel() {
        addSubview(authorLabel)
        authorLabel.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
