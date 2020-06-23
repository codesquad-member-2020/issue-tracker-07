//
//  DetailIssueCollectionViewCell.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class DetailIssueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reportingDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    static let identifier: String = "contentCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentLabel.numberOfLines = 2
    }
    
    override func systemLayoutSizeFitting( _ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
