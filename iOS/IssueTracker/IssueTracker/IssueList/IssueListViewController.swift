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
    private var isSelectedAll: Bool = false {
        didSet {
            leftNavigationButton.title = isSelectedAll ? "Deselect All" : "Select All"
        }
    }
    private var tabbarItems: [UIView]? = .init()
    private let closeIssueButton: BorderButton = .init()
    
    override func viewDidLoad() {
        setUp()
    }
    
    private func setUp() {
        setUpSearchBar()
        setUpIssueListTableView()
        setUpCloseIssueButton()
    }
    
    private func setUpSearchBar() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    private func setUpIssueListTableView() {
        issueListTableView.dataSource = dataSource
        issueListTableView.delegate = self
        issueListTableView.allowsMultipleSelectionDuringEditing = true
    }
    
    private func setUpCloseIssueButton() {
        guard tabBarController?.tabBar != nil else { return }
        closeIssueButton.setTitle("선택 이슈 닫기", for: .normal)
        closeIssueButton.titleLabel?.font = .systemFont(ofSize: 15)
        closeIssueButton.titleLabel?.textAlignment = .center
        closeIssueButton.setTitleColor(.link, for: .normal)
        closeIssueButton.frame = CGRect(x: tabBarController!.tabBar.frame.maxX - 125, y: 0, width: 125, height: 40)
    }
    
    private func updateNavigationBar() {
        rightNavigationButton.title = isEditingMode ? "Cancel" : "Edit"
        leftNavigationButton.title = isEditingMode ? "Select All" : "Filter"
        navigationItem.title = isEditingMode ? "0개 선택" : "이슈"
        navigationItem.searchController?.searchBar.isHidden = isEditingMode
    }
    
    private func updateTabbar() {
        if isEditingMode {
            tabbarItems = tabBarController?.tabBar.subviews
            tabBarController?.tabBar.subviews.forEach {
                $0.removeFromSuperview()
            }
            tabBarController?.tabBar.addSubview(closeIssueButton)
        } else {
            closeIssueButton.removeFromSuperview()
            tabbarItems?.forEach {
                tabBarController?.tabBar.addSubview($0)
            }
        }
    }
    
    private func selectAllCells() {
        for index in 0..<issueListTableView.numberOfRows(inSection: 0) {
            issueListTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    
    private func deselectAllCells() {
        for index in 0..<issueListTableView.numberOfRows(inSection: 0) {
            issueListTableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
        }
    }
    
    @IBAction func leftNavigationButtonTapped(_ sender: UIBarButtonItem) {
        if isEditingMode {
            isSelectedAll.toggle()
            isSelectedAll ? selectAllCells() : deselectAllCells()
        }
    }
    
    @IBAction func rightNavigationButtonTapped(_ sender: UIBarButtonItem) {
        isEditingMode.toggle()
        isSelectedAll = false
        updateNavigationBar()
        updateTabbar()
        issueListTableView.setEditing(isEditingMode, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRows = tableView.indexPathsForSelectedRows?.count else { return }
        isSelectedAll = (tableView.numberOfRows(inSection: 0) == selectedRows)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let selectedRows = tableView.indexPathsForSelectedRows?.count else { return }
        isSelectedAll = (tableView.numberOfRows(inSection: 0) == selectedRows)
    }
}
