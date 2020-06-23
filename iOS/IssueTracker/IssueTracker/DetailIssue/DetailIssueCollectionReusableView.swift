//
//  DetailIssueCollectionReusableView.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class DetailIssueCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var issueStateView: BorderView!
    @IBOutlet weak var issueStateLabel: UILabel!
}
