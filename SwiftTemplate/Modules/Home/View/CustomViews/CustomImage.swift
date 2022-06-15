//
//  CustomImage.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 15/06/2022.
//

import UIKit

class CustomImage: UIImageView {

    init(imageName: String, mode: ContentMode ){
        super.init(frame: .zero)
        contentMode = mode
        clipsToBounds = true
        image = UIImage(named: imageName)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
