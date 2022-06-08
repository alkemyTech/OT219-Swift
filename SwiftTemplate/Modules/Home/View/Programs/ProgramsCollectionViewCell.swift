//
//  ProgramsCollectionViewCell.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 1/6/22.
//

import UIKit

class ProgramsCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let identifier = "ProgramsCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "house")
        imageView.isUserInteractionEnabled = true
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
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private var labelDescription: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
    
    //MARK: - SetupViews
    
    func setupViews(){
        contentView.addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        imageView.setHeight(200)
        contentView.addSubview(labelWelcome)
        labelWelcome.anchor(top: imageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        contentView.addSubview(labelTitle)
        labelTitle.anchor(top: labelWelcome.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 12)
        contentView.addSubview(labelDescription)
        labelDescription.anchor(top: labelTitle.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingRight: 12)
    }
    //MARK: - Configuration CollectionViewCell
    
    func configure(with viewModel: ProgramsCollectionViewCellViewModel){
        labelTitle.text = viewModel.title
        labelDescription.text = viewModel.description
        imageView.image = UIImage(named: viewModel.nameImage) ?? UIImage(named: "logo-Alkemy")
    }
}
