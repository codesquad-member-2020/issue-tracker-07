//
//  IssueTableViewDataSource.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueTableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueTableViewCell.identifier) as? IssueTableViewCell else {
            return UITableViewCell()
        }
        
        cell.applyCollectionView(with: LabelCollectionViewDataSource())
        cell.layoutIfNeeded()
        cell.collectionViewHeight.constant = cell.labelCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        return cell
    }
}