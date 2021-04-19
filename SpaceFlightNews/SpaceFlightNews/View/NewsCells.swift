//
//  NewsCells.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Tarasova on 19.04.2021.
//

import UIKit

class NewsCells: UICollectionViewCell {

    @IBOutlet var cellGradientView: UIView!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.clear,
            UIColor.black.cgColor.copy(alpha: 0.2)!
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
                
        gradient.frame = cellGradientView.bounds
        cellGradientView.layer.addSublayer(gradient)
    }
}
