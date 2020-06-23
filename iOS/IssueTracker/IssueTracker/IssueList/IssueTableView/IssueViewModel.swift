//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/16.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class IssueViewModel: NSObject {
    var isOpen: Dynamic<Bool>
    var title: Dynamic<String>
    var number: Dynamic<Int>
    var reportingDate: Dynamic<String>
    var contents: Dynamic<String?>
    var mileStone: Dynamic<String?>
    var labels: Dynamic<[Label]?>
    
    init(issue: Issue) {
        isOpen = .init(issue.isOpen)
        title = .init(issue.title)
        number = .init(issue.id)
        reportingDate = .init(issue.reportingDate)
        contents = .init(issue.content)
        mileStone = .init(issue.milestone.first?.title)
        labels = .init(issue.labelList)
    }
}

extension IssueViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(label: labels.value?[indexPath.item])
        return cell
    }
}
