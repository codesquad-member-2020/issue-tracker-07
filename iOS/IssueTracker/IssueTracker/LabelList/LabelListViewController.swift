//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelListViewController: UIViewController {

    @IBOutlet weak var labelListTableView: UITableView!
    
    private var dataSource: LabelListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = LabelListDataSource()
        labelListTableView.dataSource = dataSource
    }
}
