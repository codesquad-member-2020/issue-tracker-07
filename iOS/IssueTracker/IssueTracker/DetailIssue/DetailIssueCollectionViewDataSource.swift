//
//  DetailIssueCollectionViewDataSource.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class DetailIssueCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var titleViewModel: IssueTitleViewModel?
    
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
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailIssueHeader", for: indexPath) as? DetailIssueCollectionReusableView else {
            return .init()
        }
        setUpTitleViewModel(header: header)
        return header
    }
    
    func insertViewModel(title viweModel: IssueTitleViewModel) {
        self.titleViewModel = viweModel
    }
    
    func setUpTitleViewModel(header: DetailIssueCollectionReusableView) {
        setUpTitleImageViewBinding(header: header)
        setUpAuthorLabelBinding(header: header)
        setUpIssueNumberLabelBinding(header: header)
        setUpTitleLabelBinding(header: header)
        setUpIssueStateBinding(header: header)
    }
    
    func setUpTitleImageViewBinding(header: DetailIssueCollectionReusableView) {
        titleViewModel?.imageURL.bind { url in
            guard let urlString = url,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) else { return }
            header.profileImageView.image = UIImage(data: data)
        }
        titleViewModel?.imageURL.fire()
    }
    
    func setUpAuthorLabelBinding(header: DetailIssueCollectionReusableView) {
        titleViewModel?.authorName.bind { authorName in
            header.authorLabel.text = authorName
        }
        titleViewModel?.authorName.fire()
    }
    
    func setUpIssueNumberLabelBinding(header: DetailIssueCollectionReusableView) {
        titleViewModel?.id.bind { issueNumber in
            header.issueNumberLabel.text = "#" + String(issueNumber ?? 0)
        }
        titleViewModel?.id.fire()
    }
    
    func setUpTitleLabelBinding(header: DetailIssueCollectionReusableView) {
        titleViewModel?.title.bind { title in
            header.titleLabel.text = title
        }
        titleViewModel?.title.fire()
    }
    
    func setUpIssueStateBinding(header: DetailIssueCollectionReusableView) {
        titleViewModel?.isOpen.bind { isOpen in
            guard let isOpen = isOpen else { return }
            header.issueStateView.backgroundColor = isOpen ? UIColor(named: "OpenBackgroundColor") : UIColor(named: "CloseBackgroundColor")
            header.issueStateLabel.text = isOpen ? "Open" : "Close"
        }
        titleViewModel?.isOpen.fire()
    }
}
