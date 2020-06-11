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
    static let identifier: String = "signUp"
    private var signUpViewModel: SignUpViewModel?
    var successHandler: () -> () = {}
    
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
    
    private func success(_ status: Bool) {
        if status {
            dismiss(animated: true) { self.successHandler() }
        } else {
            alert(title: "에러 발생", message: "중복된 아이디입니다.", actions: ["닫기": .none])
        }
    }
    
    // MARK: - IBActions
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        let body = UserCertification(userName: signUpViewModel?.userName.value,
                                     password: signUpViewModel?.password.value)
        NetworkManager.request(url: EndPoint(path: .signUp).url,
                               method: .post,
                               body: body,
                               statusCodeRange: 200...299,
                               decodable: SignUpResponse.self,
                               successHandler: { model in
                                self.success(model.status) },
                               failHandler: { error in
                                self.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none]) })
    }
}


