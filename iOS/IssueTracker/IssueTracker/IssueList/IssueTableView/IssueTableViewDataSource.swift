//
//  IssueTableViewDataSource.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/14.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueTableViewDataSource: NSObject, UITableViewDataSource {
    
    var viewModels: [IssueViewModel]?
    var editModeViewModels: [IssueViewModel]? {
        return viewModels?.filter {$0.isOpen.value}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.isEditing ? (editModeViewModels?.count ?? 0) : (viewModels?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueTableViewCell.identifier) as? IssueTableViewCell else {
            return UITableViewCell()
        }
        guard let viewModel = tableView.isEditing ? editModeViewModels?[indexPath.row] : viewModels?[indexPath.row] else { return cell }
        setUpViewModel(cell: cell, viewModel: viewModel)
        cell.layoutIfNeeded()
        cell.collectionViewHeight.constant = cell.labelCollectionView.collectionViewLayout.collectionViewContentSize.height
        return cell
    }
    
    func setUpViewModels(issues: [Issue], handler: @escaping () -> ()) {
        viewModels = issues.map { IssueViewModel(issue: $0) }
        handler()
    }
    
    func remove(at indexPath: [IndexPath], handler: @escaping ([IndexPath]) -> ()) {
        indexPath.forEach {
            viewModels?.remove(at: $0.row)
        }
        handler(indexPath)
    }
    
    private func setUpViewModel(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        setUpIsOpenBinding(cell: cell, viewModel: viewModel)
        setUpIssueTitleBinding(cell: cell, viewModel: viewModel)
        setUpIssueNumberBinding(cell: cell, viewModel: viewModel)
        setUpReportingDateBinding(cell: cell, viewModel: viewModel)
        setUpIssueDescriptionBinding(cell: cell, viewModel: viewModel)
        setUpMileStoneBinding(cell: cell, viewModel: viewModel)
        setUpLabelBinding(cell: cell, viewModel: viewModel)
    }
    
    private func setUpIsOpenBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        viewModel.isOpen.bind { isOpen in
            cell.statusImageView.tintColor = isOpen ? .systemGreen : .systemOrange
        }
        viewModel.isOpen.fire()
    }
    
    private func setUpIssueTitleBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        viewModel.title.bind { title in
            cell.titleLabel.text = title
        }
        viewModel.title.fire()
    }
    
    private func setUpIssueNumberBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        viewModel.number.bind { number in
            cell.numberLabel.text = "#\(number)"
        }
        viewModel.number.fire()
    }
    
    private func setUpReportingDateBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        viewModel.reportingDate.bind { reportingDate in
            guard let reportingDate = DateFormatter().dateConverter.date(from: reportingDate) else { return }
            cell.reportingDateLabel.text = Calendar.current.leftTime(date: reportingDate)
        }
        viewModel.reportingDate.fire()
    }
    
    private func setUpIssueDescriptionBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        viewModel.contents.bind { description in
            cell.contentsLabel.text = description ?? "내용 없음"
        }
        viewModel.contents.fire()
    }
    
    private func setUpMileStoneBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        viewModel.mileStone.bind { mileStone in
            cell.mileStoneLabel.isHidden = (mileStone == nil)
            cell.mileStoneLabel.text = mileStone
        }
        viewModel.mileStone.fire()
    }
    
    private func setUpLabelBinding(cell: IssueTableViewCell, viewModel: IssueViewModel) {
        cell.labelCollectionView.dataSource = viewModel
        viewModel.labels.bind { _ in
            cell.labelCollectionView.reloadData()
        }
        viewModel.labels.fire()
    }
}
