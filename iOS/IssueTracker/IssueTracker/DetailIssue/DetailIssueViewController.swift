//
//  DetailIssueViewController.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/18.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class DetailIssueViewController: UIViewController {

    // MARK: - Properties
    static let identifier: String = "DetailIssue"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil), animated: true)
    }
}
