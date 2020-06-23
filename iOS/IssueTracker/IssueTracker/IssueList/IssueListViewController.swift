//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController, Editable {
    
    @IBOutlet weak var issueListTableView: UITableView!
    @IBOutlet weak var rightNavigationButton: UIBarButtonItem!
    @IBOutlet weak var leftNavigationButton: UIBarButtonItem!
    
    private var searchController: UISearchController = UISearchController()
    private var dataSource: IssueTableViewDataSource!
    private var isSelectedAll: Bool = false {
        didSet {
            leftNavigationButton.title = isSelectedAll ? "Deselect All" : "Select All"
        }
    }
    var isEditingMode: Bool = false
    private var tabbarItems: [UIView]? = .init()
    private let closeIssueButton: BorderButton = .init()
    private var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        setUp()
        loadIssues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "이슈"
    }
    
    private func loadIssues() {
        IssueListUseCase().loadIssueList(networkManager: NetworkManager(),
                                         successHandler: { [unowned self] issues in
                                            self.dataSource.setUpViewModels(issues: issues,
                                                                            handler: {
                                                                                self.issueListTableView.reloadData()
                                            })},
                                         failHandler: { [unowned self] error in
                                            let alert = UIAlertController.alert(title: "에러 발생",
                                                                                message: error.localizedDescription,
                                                                                actions: ["닫기": .none])
                                            self.present(alert, animated: true)
        })
    }
    
    private func setUp() {
        setUpSearchBar()
        setUpDataSourceBinding()
        setUpIssueListTableView()
        setUpCloseIssueButton()
    }
    
    private func setUpDataSourceBinding() {
        dataSource = IssueTableViewDataSource(editable: self)
    }
    
    private func setUpSearchBar() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    private func setUpIssueListTableView() {
        issueListTableView.dataSource = dataSource
        issueListTableView.delegate = self
        issueListTableView.allowsMultipleSelectionDuringEditing = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(issueCellTapped(_:)))
        issueListTableView.addGestureRecognizer(tapGesture)
    }
    
    private func setUpCloseIssueButton() {
        guard tabBarController?.tabBar != nil else { return }
        closeIssueButton.setTitle("선택 이슈 닫기", for: .normal)
        closeIssueButton.titleLabel?.font = .systemFont(ofSize: 15)
        closeIssueButton.titleLabel?.textAlignment = .center
        closeIssueButton.setTitleColor(.link, for: .normal)
        closeIssueButton.frame = CGRect(x: tabBarController!.tabBar.frame.maxX - 125, y: 0, width: 125, height: 40)
        closeIssueButton.addTarget(self, action: #selector(closeIssues), for: .touchUpInside)
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
            navigationItem.title = "\(issueListTableView.indexPathsForSelectedRows?.count ?? 0)개 선택"
        }
    }
    
    @IBAction func rightNavigationButtonTapped() {
        isEditingMode.toggle()
        tapGesture.isEnabled = !isEditingMode
        isSelectedAll = false
        updateNavigationBar()
        updateTabbar()
        issueListTableView.setEditing(isEditingMode, animated: true)
        issueListTableView.reloadData()
    }
    
    @objc func issueCellTapped(_ sender: UITapGestureRecognizer) {
        guard !isEditingMode else { return }
        let location = sender.location(ofTouch: 0, in: issueListTableView)
        guard issueListTableView.indexPathForRow(at: location) != nil else { return }
        guard let detailIssueViewController = storyboard?.instantiateViewController(withIdentifier: DetailIssueViewController.identifier) else { return }
        navigationController?.pushViewController(detailIssueViewController, animated: true)
    }
    
    @objc func closeIssues() {
        guard let selectedIndexPath = self.issueListTableView.indexPathsForSelectedRows else { return }
        guard let editModeViewModels = self.dataSource.editModeViewModels else { return }
        let ids = selectedIndexPath.map { editModeViewModels[$0.row].number.value }
        IssueListUseCase().requestChangeIssuesState(networkManager: NetworkManager(),
                                                    issueIds: ids,
                                                    state: .close,
                                                    successHandler: { [unowned self] _ in
                                                        editModeViewModels
                                                            .filter { ids.contains($0.number.value) }
                                                            .forEach { $0.isOpen.value = false }
                                                        self.rightNavigationButtonTapped()},
                                                    failHandler: { [unowned self] error in
                                                        let alert = UIAlertController.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none])
                                                        self.present(alert, animated: true)
        })
    }
}

extension IssueListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let isOpen = self.dataSource.viewModels?[indexPath.row].isOpen.value else { return nil }
        let action = isOpen ? closeAction(at: indexPath) : openAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func closeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Close", handler: { (_, _, complete) in
            guard let selectedIssueNumber = self.dataSource.viewModels?[indexPath.row].number.value else { return }
            IssueListUseCase().requestChangeIssuesState(networkManager: NetworkManager(),
                                                        issueIds: [selectedIssueNumber],
                                                        state: .close,
                                                        successHandler: { [unowned self] _ in
                                                            self.dataSource.viewModels?[indexPath.row].isOpen.value = false
                                                            complete(true)},
                                                        failHandler: { [unowned self] error in
                                                            let alert = UIAlertController.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none])
                                                            self.present(alert, animated: true)
            })
        })
        action.backgroundColor = .systemOrange
        
        return action
    }
    
    func openAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Open", handler: { (_, _, complete) in
            guard let selectedIssueNumber = self.dataSource.viewModels?[indexPath.row].number.value else { return }
            IssueListUseCase().requestChangeIssuesState(networkManager: NetworkManager(),
                                                        issueIds: [selectedIssueNumber],
                                                        state: .open,
                                                        successHandler: { [unowned self] _ in
                                                            self.dataSource.viewModels?[indexPath.row].isOpen.value = true
                                                            complete(true)},
                                                        failHandler: { [unowned self] error in
                                                            let alert = UIAlertController.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none])
                                                            self.present(alert, animated: true)
            })
        })
        action.backgroundColor = .systemGreen
        
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { [unowned self] (_, _, complete) in
            guard let id = self.dataSource.viewModels?[indexPath.row].number.value else { return }
            IssueListUseCase().requestDeleteIssue(networkManager: NetworkManager(),
                                                  issueId: id,
                                                  successHandler: { _ in
                                                    self.dataSource.remove(at: [indexPath], handler: {
                                                        self.issueListTableView.deleteRows(at: $0, with: .automatic)
                                                    })
                                                    complete(true)},
                                                  failHandler: { [unowned self] error in
                                                    let alert = UIAlertController.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none])
                                                    self.present(alert, animated: true)
            })
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isEditingMode else { return }
        let selectRows = tableView.indexPathsForSelectedRows?.count ?? 0
        isSelectedAll = (tableView.numberOfRows(inSection: 0) == selectRows)
        navigationItem.title = "\(selectRows)개 선택"
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard isEditingMode else { return }
        let selectRows = tableView.indexPathsForSelectedRows?.count ?? 0
        isSelectedAll = (tableView.numberOfRows(inSection: 0) == selectRows)
        navigationItem.title = "\(selectRows)개 선택"
    }
}
