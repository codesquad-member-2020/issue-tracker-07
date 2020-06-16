//
//  IssueTableViewCell.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var mileStoneLabel: BorderLabel!
    static let identifier: String = "IssueCell"
    private var dataSource: LabelCollectionViewDataSource? {
        didSet {
            labelCollectionView.dataSource = dataSource
        }
    }

    func configure(issue: Issue?) {
        guard let issue = issue else { return }
        selectedBackgroundView = UIView()
        dataSource = LabelCollectionViewDataSource(handler: { [unowned self] in
            self.labelCollectionView.reloadData()
        })
        dataSource?.labels = issue.labels
    }
}

