//
//  DetailIssueViewController.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/18.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class DetailIssueViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var issueDetailCollectionView: UICollectionView!
    
    // MARK: - Properties
    static let identifier: String = "DetailIssue"
    private var dataSource: DetailIssueCollectionViewDataSource!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DetailIssueCollectionViewDataSource()
        issueDetailCollectionView.dataSource = dataSource
        guard let layout = issueDetailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.estimatedItemSize = CGSize(width: view.frame.width, height: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil), animated: true)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .automatic
    }
}
