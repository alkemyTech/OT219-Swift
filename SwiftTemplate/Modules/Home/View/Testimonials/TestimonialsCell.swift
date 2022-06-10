//
//  TestimonialsCell.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 09/06/2022.
//

import UIKit

class TestimonialsCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "testimonialsTableViewIdentifier"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Nombre y apellido"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textColor = .black
        label.text = "testimonialstestimonialstestimonialstestimonialstestimonialstestimonialstestimonialstestimonialstestimonialstestimonialstestimonialstestimonials"
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)

        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
                
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handlers
    

}
