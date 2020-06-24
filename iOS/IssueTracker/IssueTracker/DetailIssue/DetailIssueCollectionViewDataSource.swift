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
    private var commentViewModels: [IssueCommentViewModel]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentViewModels?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIssueCollectionViewCell.identifier, for: indexPath) as? DetailIssueCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            cell.contentLabel.numberOfLines = 0
        }
        
        guard let viewModel = commentViewModels?[indexPath.item] else { return cell }
        
        setUpContentViewModel(cell: cell, viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailIssueHeader", for: indexPath) as? DetailIssueCollectionReusableView else {
            return .init()
        }
        setUpTitleViewModel(header: header)
        return header
    }
    
    func insertViewModel(title viewModel: IssueTitleViewModel) {
        self.titleViewModel = viewModel
    }
    
    func insertViewModel(content viewModel: [IssueCommentViewModel]) {
        self.commentViewModels = viewModel
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
    
    func setUpContentViewModel(cell: DetailIssueCollectionViewCell, viewModel: IssueCommentViewModel) {
        setUpContentImageViewBinding(cell: cell, viewModel: viewModel)
        setUpContentAuthorLabelBinding(cell: cell, viewModel: viewModel)
        setUpReportingLabelBinding(cell: cell, viewModel: viewModel)
        setUpContentLabelBinding(cell: cell, viewModel: viewModel)
    }
    
    func setUpContentImageViewBinding(cell: DetailIssueCollectionViewCell, viewModel: IssueCommentViewModel) {
        viewModel.imageURL.bind { url in
            guard let urlString = url,
                let url = URL(string: urlString),
                let data = try? Data(contentsOf: url) else { return }
            cell.profileImageView.image = UIImage(data: data)
        }
        viewModel.imageURL.fire()
    }
    
    func setUpContentAuthorLabelBinding(cell: DetailIssueCollectionViewCell, viewModel: IssueCommentViewModel) {
        viewModel.authorName.bind { authorName in
            cell.authorLabel.text = authorName
        }
        viewModel.authorName.fire()
    }
    
    func setUpReportingLabelBinding(cell: DetailIssueCollectionViewCell, viewModel: IssueCommentViewModel) {
        viewModel.reportingDate.bind { reportingDate in
            guard let reportingDate = reportingDate,
                let date = DateFormatter().dateConverter.date(from: reportingDate) else { return }
            cell.reportingDateLabel.text = Calendar.current.leftTime(date: date)
        }
        viewModel.reportingDate.fire()
    }
    
    func setUpContentLabelBinding(cell: DetailIssueCollectionViewCell, viewModel: IssueCommentViewModel) {
        viewModel.content.bind { content in
            cell.contentLabel.text = content
        }
        viewModel.content.fire()
    }
}
