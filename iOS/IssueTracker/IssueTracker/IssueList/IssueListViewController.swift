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
    
    private var searchController: UISearchController = UISearchController()
    private var dataSource: UITableViewDataSource = IssueTableViewDataSource()
    
    override func viewDidLoad() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        issueListTableView.dataSource = dataSource
        issueListTableView.delegate = self
        
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
