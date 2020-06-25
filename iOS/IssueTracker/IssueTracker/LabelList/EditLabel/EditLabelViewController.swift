//
//  EditLabelViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class EditLabelViewController: UIViewController {
    
    @IBOutlet weak var configurationView: ConfigurationView!
    static let identifier: String = "editLabelViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        configurationView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
