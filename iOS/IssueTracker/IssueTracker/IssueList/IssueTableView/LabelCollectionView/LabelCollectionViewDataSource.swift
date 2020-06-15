//
//  LabelCollectionViewDataSource.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var labels: [Label]? {
        didSet {
            handler()
        }
    }
    var handler: () -> ()
    
    init(handler: @escaping () -> () = {}) {
        self.handler = handler
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(label: labels?[indexPath.item])
        return cell
    }
}
