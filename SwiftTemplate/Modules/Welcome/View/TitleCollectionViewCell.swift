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
    
    private var labelDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.autoresizesSubviews = true
        label.font = .systemFont(ofSize: 17, weight: .medium)
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
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        labelWelcome.frame = CGRect(x: 5,
                                    y:contentView.frame.size.height-320,
                                    width:contentView.frame.size.width-10,
                                    height: 50)
        
        labelDescription.frame = CGRect(x: 5,
                                        y: contentView.frame.size.height-270,
                                        width: contentView.frame.size.width-10,
                                        height: 265)
        imageView.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.frame.size.width-10,
                                 height: contentView.frame.size.height-320)
    }
    //MARK: - Setup
    func setupViews(){
        contentView.addSubview(labelWelcome)
        contentView.addSubview(imageView)
        contentView.addSubview(labelDescription)
    }
    //MARK: - Configuration CollectionViewCell
    func configure(with viewModel: TitleCollectionViewCellViewModel){
        labelDescription.text = viewModel.description
        imageView.image = UIImage(named: viewModel.nameImage) ?? UIImage(named: "logo-Alkemy")
    }
}
