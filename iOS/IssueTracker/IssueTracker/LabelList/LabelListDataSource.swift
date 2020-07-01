//
//  LabelListDataSource.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelListDataSource: NSObject, UITableViewDataSource {
    
    private var viewModels: [LabelViewModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.identifier, for: indexPath) as? LabelCell else { return UITableViewCell() }
        guard let viewModel = viewModels?[indexPath.row] else { return cell }
        setUpBinding(cell: cell, viewModel: viewModel)
        
        return cell
    }
    
    func insertViewModel(labels viewModels: [LabelViewModel]?) {
        self.viewModels = viewModels
    }
    
    private func setUpBinding(cell: LabelCell, viewModel: LabelViewModel) {
        setUpBackgroundColorBinding(cell: cell, viewModel: viewModel)
        setUpTitleTextBinding(cell: cell, viewModel: viewModel)
        setUpDescriptionBinding(cell: cell, viewModel: viewModel)
    }
    
    private func setUpBackgroundColorBinding(cell: LabelCell, viewModel: LabelViewModel) {
        viewModel.backgroundColor.bind { color in
            cell.titleLabel.backgroundColor = color
        }
        viewModel.backgroundColor.fire()
    }
    
    private func setUpTitleTextBinding(cell: LabelCell, viewModel: LabelViewModel) {
        viewModel.title.bind { text in
            cell.titleLabel.text = text
        }
        viewModel.title.fire()
    }
    
    private func setUpDescriptionBinding(cell: LabelCell, viewModel: LabelViewModel) {
        viewModel.description.bind { description in
            cell.descriptionLabel.text = description
        }
        viewModel.description.fire()
    }
}

