//
//  SignUpViewController.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userNameInputView: InputStackView!
    @IBOutlet weak var passwordInputView: InputStackView!
    @IBOutlet weak var confirmPasswordInputView: InputStackView!
    @IBOutlet weak var createAccountButton: BorderButton!
    
    // MARK: - Properties
    private var signUpViewModel: SignUpViewModel?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Methods
    // MARK: SetUp
    private func setUp() {
        setUpSignUpViewModel()
        setUpUserNameInputView()
        setUpPasswordInputView()
        setUpConfirmPasswordInputView()
        setUpCreateButton()
    }
    
    private func setUpSignUpViewModel() {
        signUpViewModel = SignUpViewModel()
        userNameInputView.bind { [unowned self] userName in
            self.signUpViewModel?.userName.value = userName
        }
        passwordInputView.bind { [unowned self] password in
            self.signUpViewModel?.password.value = password
        }
        confirmPasswordInputView.bind { [unowned self] confirmPassword in
            self.signUpViewModel?.confirmPassword.value = confirmPassword
        }
    }
    
    private func setUpUserNameInputView() {
        signUpViewModel?.isUserNameValid.bind { [unowned self] isValid in
            self.userNameInputView.textFieldBorderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        }
    }
    
    private func setUpPasswordInputView() {
        signUpViewModel?.isPasswordValid.bind { [unowned self] isValid in
            self.passwordInputView.textFieldBorderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        }
    }
    
    private func setUpConfirmPasswordInputView() {
        signUpViewModel?.isConfirmPasswordValid.bind { [unowned self] isValid in
            self.confirmPasswordInputView.textFieldBorderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        }
    }
    
    private func setUpCreateButton() {
        signUpViewModel?.isEnabled.bindAndFire { [unowned self] isEnabled in
            self.createAccountButton.isEnabled = isEnabled
            UIView.animate(withDuration: 0.5, animations: {
                self.createAccountButton.alpha = isEnabled ? 1 : 0.5
            })
        }
    }
}
