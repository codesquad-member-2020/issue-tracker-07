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
    
    // MARK: - Properties
    private var userNameInputStackView: InputStackView!
    private var passwordInputStackView: InputStackView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - Methods
    // MARK: SetUp
    private func setUp() {
        userNameInputStackView = setUpInputStackView(with: "Username")
        signInStackView.addArrangedSubview(userNameInputStackView)
        passwordInputStackView = setUpInputStackView(with: "Password",
                                                     isPassword: true)
        signInStackView.addArrangedSubview(passwordInputStackView)
    }
    
    private func setUpInputStackView(with title: String?, isPassword: Bool = false) -> InputStackView {
        let inputStackView = InputStackView()
        inputStackView.isSecureTextEntry = isPassword
        inputStackView.update(with: title)
        return inputStackView
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

