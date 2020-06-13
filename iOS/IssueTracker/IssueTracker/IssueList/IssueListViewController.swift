//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController {
    
    private var searchController = UISearchController()
    
    override func viewDidLoad() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
}
