//
//  SeeMoreCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 01/06/2022.
//

import UIKit

class SeeMoreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SeeMoreCollectionViewCell"
    
    private let frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SeeMoreIcon")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        addSubview(frontImageView)
        
        frontImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        frontImageView.setHeight(200)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // frontImageView.frame = contentView.bounds
    }
    
}
