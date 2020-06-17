//
//  LabelLayout.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return [] }
        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0

        for attribute in layoutAttributes {
            guard attribute.representedElementCategory == .cell else { continue }
            if attribute.frame.origin.y >= y {
                x = sectionInset.left
            }
            attribute.frame.origin.x = x
            x += attribute.frame.width + minimumInteritemSpacing
            y = attribute.frame.maxY
        }
        
        return layoutAttributes
    }
}
