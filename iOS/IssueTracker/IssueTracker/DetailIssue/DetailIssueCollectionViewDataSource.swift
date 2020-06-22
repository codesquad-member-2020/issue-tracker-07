//
//  DetailIssueCollectionViewDataSource.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class DetailIssueCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIssueCollectionViewCell.identifier, for: indexPath) as? DetailIssueCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            cell.contentLabel.numberOfLines = 0
        }
        cell.contentLabel.text = "내용이 들어갈 자리\n내용이 들어갈 자리\n내용이 들어갈 자리\n내용이 들어갈 자리"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailIssueHeader", for: indexPath)
        return header
    }
}
