//
//  LabelCollectionViewDataSource.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else {return UICollectionViewCell()}
        cell.titleLabel.text = (0...Int.random(in: 1...14)).reduce(into: "") {
            $0 += String($1)
        }
        return cell
    }
}
