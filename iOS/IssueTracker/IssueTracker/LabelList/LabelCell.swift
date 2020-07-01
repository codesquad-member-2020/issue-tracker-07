//
//  LabelCell.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    static let identifier: String = "labelCell"

    @IBOutlet weak var titleLabel: BorderLabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

