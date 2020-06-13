//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController {
    
    @IBOutlet weak var IssueListTableView: UITableView!
    
    private var searchController = UISearchController()
    
    override func viewDidLoad() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        IssueListTableView.dataSource = self
    }
}

extension IssueListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell") else {
            return UITableViewCell()
        }
        return cell
    }
}
