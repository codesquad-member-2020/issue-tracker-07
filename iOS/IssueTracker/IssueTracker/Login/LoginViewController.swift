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
    @IBOutlet weak var signInStackView: UIStackView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func warningCloseButtonTapped(_ sender: UIButton) {
        UIView.animateKeyframes(withDuration: 0.75, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2) {
                self.warningView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
                self.warningView.isHidden = true
            }
        })
    }
}

