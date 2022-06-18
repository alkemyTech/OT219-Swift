//
//  CustomButton.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 15/06/2022.
//

import UIKit

class CustomButton: UIButton {

    init(titleLabel: String, width: CGFloat){
        super.init(frame: .zero)
        tintColor = UIColor.white
        setTitle(titleLabel, for: .normal)
        backgroundColor = UIColor(named: "ButtonColor")
        setDimensions(height: 50, width: width)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        layer.cornerRadius = 10.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
