//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController {
    
    @IBOutlet weak var issueListTableView: UITableView!
    @IBOutlet weak var rightNavigationButton: UIBarButtonItem!
    @IBOutlet weak var leftNavigationButton: UIBarButtonItem!
    
    private var searchController: UISearchController = UISearchController()
    private var dataSource: UITableViewDataSource = IssueTableViewDataSource()
    private var isEditingMode: Bool = false
    
    override func viewDidLoad() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        issueListTableView.dataSource = dataSource
        issueListTableView.delegate = self
    }
    
    private func updateNavigationBar() {
        rightNavigationButton.title = isEditingMode ? "Cancel" : "Edit"
        leftNavigationButton.title = isEditingMode ? "Select All" : "Filter"
        navigationItem.title = isEditingMode ? "0개 선택" : "이슈"
        navigationItem.searchController?.searchBar.isHidden = isEditingMode
    }
    
    @IBAction func rightNavigationButtonTapped(_ sender: UIBarButtonItem) {
        isEditingMode.toggle()
        updateNavigationBar()
    }
}

extension IssueListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title: "Close",handler: { (_, _, _) in
            
        })
        closeAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete",handler: { (_, _, _) in

        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
