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
    private var labelList: [Label]? {
        didSet {
            guard oldValue != nil else {
                dataSource.insertViewModel(labels: labelList?.map { LabelViewModel(label: $0) })
                labelListTableView.reloadData()
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = LabelListDataSource()
        labelListTableView.dataSource = dataSource
        setUp()
    }
    
    private func setUp() {
        requestLableList()
    }
    
    private func requestLableList() {
        LabelListUseCase().request(sucessHandler: { [unowned self] in
            self.labelList = $0
        }, failureHandler: { [unowned self] in
            let alert = UIAlertController.alert(title: "에러 발생", message: $0.localizedDescription, actions: ["닫기" : .none])
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func plusButtonTapped(_ sender: UIBarButtonItem) {
        guard let editLabelViewController = storyboard?.instantiateViewController(withIdentifier: EditLabelViewController.identifier) as? EditLabelViewController else { return }
        editLabelViewController.modalPresentationStyle = .overFullScreen
        present(editLabelViewController, animated: true)
    }
}
