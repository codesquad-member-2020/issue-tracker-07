//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier: String = "LabelCell"
    
    func configure(label: Label?) {
        titleLabel.text = label?.title
        contentView.backgroundColor = UIColor(hex: label?.backgroundColor)
        contentView.layer.borderColor = UIColor(hex: label?.backgroundColor)?.cgColor
    }
}
