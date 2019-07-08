//
//  StoryHeaderCollectionViewCell.swift
//  StoryDemo
//
//  Created by Sneha Harke on 24/06/19.
//  Copyright © 2019 Sneha Harke. All rights reserved.
//

import UIKit

class StoryHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = CGFloat(50)
        let standardHeight = CGFloat(50)
        
        let delta = 1 - ((featuredHeight - CGFloat(50)) / (featuredHeight - standardHeight))
        print("-------\(delta)")
        let scale = max(delta, 1.0)
        
        backView.transform = CGAffineTransform(scaleX: scale, y: scale)
       // backView.alpha = delta
        
    }
    
}
