//
//  StoriesLayout.swift
//  StoryDemo
//
//  Created by Sneha Harke on 24/06/19.
//  Copyright © 2019 Sneha Harke. All rights reserved.
//

import Foundation
import UIKit

struct StoryHeaderCellSizes {
    struct Width  {
        static let featuredCellWidth: CGFloat = screenWidth/2
        static let standardCellWidth: CGFloat = screenWidth/4
    }
    
    struct Height {
        static let featuredCellHeight: CGFloat = 100
        static let standardCellHeight: CGFloat = 70
    }
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

// Screen width
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

class StoriesLayout: UICollectionViewFlowLayout {
    
    var dragOffSet : CGFloat = screenWidth/2 - screenWidth/4
    var cache: [UICollectionViewLayoutAttributes] = []
    
    var featuredItemIndex : Int {
        return max(0, Int(((collectionView?.contentOffset.x)!/dragOffSet)))
    }
    
    var nextItemPercentageOffset: CGFloat {
        return (collectionView!.contentOffset.x / dragOffSet) - CGFloat(featuredItemIndex)
    }

    var width: CGFloat {
        return collectionView!.bounds.width
    }

    var height: CGFloat {
        return collectionView!.bounds.height
    }
    
    var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }

}

extension StoriesLayout {
    
    override var collectionViewContentSize : CGSize {
        let contentWidth = (CGFloat(numberOfItems) * dragOffSet) + (width - dragOffSet)
        return CGSize(width: contentWidth, height: height)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        let standardWidth = StoryHeaderCellSizes.Width.standardCellWidth
        let featuredWidth = StoryHeaderCellSizes.Width.featuredCellWidth
        
        let standardHeight = StoryHeaderCellSizes.Height.standardCellHeight
        let featuredHeight = StoryHeaderCellSizes.Height.featuredCellHeight
        
        var frame = CGRect.zero
        var x: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // Initially set the width & height of the cell to the standard width & height
            var width = standardWidth
            var heightt = StoryHeaderCellSizes.Height.standardCellHeight
            attributes.alpha = 0.5
            
            if indexPath.item == featuredItemIndex {
                // The featured cell
                attributes.alpha = 1
                if nextItemPercentageOffset > 0 {
                    width = featuredWidth - max((standardWidth) * nextItemPercentageOffset, 0)
                    heightt = featuredHeight - max((standardHeight) * nextItemPercentageOffset, 0)
                    x = collectionView!.contentOffset.x - max(nextItemPercentageOffset, 0)
                } else {
                    let xOffset = standardWidth * nextItemPercentageOffset
                    x = collectionView!.contentOffset.x - xOffset
                    width = featuredWidth
                    heightt = featuredHeight
                }
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                // The cell directly below the featured cell, which grows as the user scrolls
                let maxX = x + standardWidth
                width = standardWidth + max((featuredWidth - standardWidth) * nextItemPercentageOffset, 0)
                heightt = standardHeight + max((featuredHeight-standardHeight) * nextItemPercentageOffset, 0)
                x = maxX - width
                attributes.alpha = 0.5
            }
            frame = CGRect(x: x, y: 0, width: width, height: heightt)
            attributes.frame = frame
            cache.append(attributes)
            x = frame.maxX
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
