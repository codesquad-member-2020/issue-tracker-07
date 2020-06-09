//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var warningView: BorderView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func warningCloseButtonTapped(_ sender: UIButton) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, animations: {
            self.warningView.alpha = 0
        }, completion: { _ in
            self.warningView.isHidden = true
        })
    }
}

