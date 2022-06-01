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
        return imageView
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        contentView.addSubview(frontImageView)
        contentView.addSubview(nameLabel)
        
        nameLabel.centerX(inView: frontImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frontImageView.frame = contentView.bounds
    }
    
    public func configureCell(with model:News){
        guard let urlString = URL(string: "\(model.image ?? "")") else {return}
        self.frontImageView.load(url: urlString)
        nameLabel.text = model.name
    }
}
