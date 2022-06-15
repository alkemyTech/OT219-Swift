//
//  CustomLabel.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 15/06/2022.
//

import UIKit

class CustomLabel: UILabel {

    init(label: String, fontSize: CGFloat, fontWeight: UIFont.Weight){
        super.init(frame: .zero)
        
        text = label
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
