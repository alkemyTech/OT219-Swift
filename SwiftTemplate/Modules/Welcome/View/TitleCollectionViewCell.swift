//
//  TitleCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 1/6/22.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "TitleCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        return imageView
    }()
    
    private var labelWelcome: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Hola! Bienvenidx"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private var labelDescription: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup
    func setupViews(){
        contentView.backgroundColor = .white
        contentView.addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5)
        imageView.setHeight(200)
        
        contentView.addSubview(labelWelcome)
        labelWelcome.anchor(top: imageView.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 12)
        contentView.addSubview(labelTitle)
        labelTitle.anchor(top: labelWelcome.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 12)
        
        contentView.addSubview(labelDescription)
        labelDescription.anchor(top: labelTitle.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingRight: 12)
    }

    //MARK: - Configuration CollectionViewCell
    func configure(with viewModel: TitleCollectionViewCellViewModel){
        labelTitle.text = viewModel.titleDescription
        labelDescription.text = viewModel.description
        imageView.image = UIImage(named: viewModel.nameImage) ?? UIImage(named: "logo-Alkemy")
    }
}
