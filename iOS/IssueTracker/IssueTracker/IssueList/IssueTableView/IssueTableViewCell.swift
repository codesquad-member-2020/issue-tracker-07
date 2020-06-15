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
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueNumerLabel: UILabel!
    @IBOutlet weak var issueDescriptionLabel: UILabel!
    @IBOutlet weak var mileStoneLabel: BorderLabel!
    static let identifier: String = "IssueCell"
    private var dataSource: LabelCollectionViewDataSource? {
        didSet {
            labelCollectionView.dataSource = dataSource
        }
    }
    
    func configure(issue: Issue?) {
        selectedBackgroundView = UIView()
        statusImageView.tintColor = (issue?.isOpen ?? false) ? .systemGreen : .systemRed
        issueTitleLabel.text = issue?.title
        issueDescriptionLabel.text = issue?.description
        issueNumerLabel.text = "#\(issue?.id ?? 0)"
        mileStoneLabel.text = issue?.mileStone?.title
        mileStoneLabel.isHidden = issue?.mileStone == nil
        dataSource = LabelCollectionViewDataSource(handler: { [unowned self] in
            self.labelCollectionView.reloadData()
        })
        dataSource?.labels = issue?.labels
    }
}
