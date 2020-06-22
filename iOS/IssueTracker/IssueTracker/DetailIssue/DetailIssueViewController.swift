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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        issueDetailCollectionView.dataSource = self
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

extension DetailIssueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailIssueHeader", for: indexPath)
        return header
    }
}
