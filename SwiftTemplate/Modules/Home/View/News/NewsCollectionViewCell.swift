//
//  NewsCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewsCollectionViewCell"
    
    private let frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubview(frontImageView)
        frontImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        frontImageView.setHeight(200)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: frontImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor,right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model:News){
        guard let urlString = URL(string: "\(model.image ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.frontImageView.load(url: urlString)
            self?.nameLabel.text = model.name
            self?.descriptionLabel.text = model.content
        }
        
    }
}
