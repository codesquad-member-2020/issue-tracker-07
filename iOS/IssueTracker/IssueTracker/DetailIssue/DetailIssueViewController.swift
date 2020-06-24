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
    private var issueInfo: IssueInfo? {
        didSet {
            guard oldValue != nil else {
                insertTitleViewModel()
                insertContentViewModels()
                return
            }
        }
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DetailIssueCollectionViewDataSource()
        issueDetailCollectionView.dataSource = dataSource
        guard let layout = issueDetailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.estimatedItemSize = CGSize(width: view.frame.width, height: .zero)
        requestIssueInfo()
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
    
    private func requestIssueInfo() {
        DetailIssueUseCase().mockRequestIssueInfoSuccess(successHandler: { [unowned self] issueInfo in
            self.issueInfo = issueInfo
        })
    }
    
    private func insertTitleViewModel() {
        let titleViewModel = IssueTitleViewModel(issueInfo: issueInfo)
        dataSource.insertViewModel(title: titleViewModel)
    }
    
    private func insertContentViewModels() {
        var viewmodels = [IssueCommentViewModel]()
        viewmodels.append(contentsOf: issueInfo?.comments.map { IssueCommentViewModel(comment: $0) } ?? [])
        dataSource.insertViewModel(content: viewmodels)
    }
}
