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
    private var loginUseCase: LoginUseCase = .init()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        signUpButtonBinding()
    }
    
    // MARK: - Methods
    private func setUp() {
        setUpSignInViewModel()
    }
    
    private func setUpSignInViewModel() {
        signInViewModel = SignInViewModel()
        userNameInputView.bind { [unowned self] userName in
            self.signInViewModel?.userName.value = userName
        }
        passwordInputView.bind { [unowned self] password in
            self.signInViewModel?.password.value = password
        }
    }
    
    private func signUpButtonBinding() {
        signInViewModel?.isEnabled.bindAndFire { [unowned self] isEnabled in
            self.signInButton.isEnabled = isEnabled
            UIView.animate(withDuration: 0.5, animations: {
                self.signInButton.alpha = isEnabled ? 1 : 0.5
            })
        }
    }
    
    // MARK: - Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func warningCloseButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.75) {
            self.warningView.alpha = 0
            self.warningView.isHidden = true
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        loginUseCase.loginFail { response in
            if response {
                
            } else {
                UIView.animate(withDuration: 0.75,
                               delay: 0,
                               options: .allowUserInteraction,
                               animations: {
                                self.warningView.alpha = 1
                                self.warningView.isHidden = false })
            }
        }
    }
}

