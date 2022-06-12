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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bgColorView = UIView()
        let leftSpace: CGFloat = 4.0
        let rightSpace: CGFloat = 4.0
        let topSpace: CGFloat = 6.0
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: topSpace, left: leftSpace, bottom: 0, right: rightSpace))
        
        imageTest.circleImageView()
        
//        testimonialLabel.numberOfLines = 0
//        testimonialLabel.lineBreakMode = .byWordWrapping
//        testimonialLabel.sizeToFit()

        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
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

