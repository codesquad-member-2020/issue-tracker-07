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
    static let identifier: String = "IssueCell"
    private var dataSource: UICollectionViewDataSource? {
        didSet {
            labelCollectionView.dataSource = dataSource
        }
    }
    
    func applyCollectionView(with dataSource: UICollectionViewDataSource) {
        self.dataSource = dataSource
    }
}
