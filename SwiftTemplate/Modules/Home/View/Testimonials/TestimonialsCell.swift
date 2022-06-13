//
//  TestimonialsCell.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 09/06/2022.
//

import UIKit

class TestimonialsCell: UITableViewCell {
    static let identifier = "ReusableTestimonialCell"

    @IBOutlet weak var imageTest: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var testimonialLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bgColorView = UIView()
        
        imageTest.circleImageView()
        
        containerView.layer.cornerRadius = 15.0
        self.containerView.layer.borderWidth = 5.0
        self.containerView.layer.borderColor = UIColor.clear.cgColor
        self.containerView.layer.masksToBounds = true
        self.selectedBackgroundView = bgColorView
    }
    
    public func configureCell(with model: Testimonials){
        guard let urlString = URL(string: "\(model.image ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = model.name
            self?.testimonialLabel.text = "\"\(model.description ?? "")\""
            self?.imageTest.load(url: urlString)
        }
    }
}

