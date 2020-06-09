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
    @IBOutlet weak var userNameInputView: InputStackView!
    @IBOutlet weak var passwordInputView: InputStackView!
    @IBOutlet weak var signInButton: BorderButton!
    
    // MARK: - Properties
    private var signInViewModel: SignInViewModel?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInViewModel = SignInViewModel()
        userNameInputView.bind { [unowned self] userName in
            self.signInViewModel?.userName.value = userName
        }
        passwordInputView.bind { [unowned self] password in
            self.signInViewModel?.password.value = password
        }
        signInViewModel?.isEnabled.bindAndFire { [unowned self] isEnabled in
            self.signInButton.isEnabled = isEnabled
            UIView.animate(withDuration: 0.5, animations: {
                self.signInButton.alpha = isEnabled ? 1 : 0.5
            })
        }
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

