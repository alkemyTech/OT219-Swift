//
//  ProfileCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 07/06/2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileCollectionViewCell"
    
    private let frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "profilePic")
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Roberto Martinez"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private var rolLabel: UILabel = {
        let label = UILabel()
        label.text = "Cordinador"
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubview(frontImageView)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, rolLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .center
        addSubview(stack)
        
        stack.anchor(bottom: bottomAnchor, paddingBottom: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frontImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
