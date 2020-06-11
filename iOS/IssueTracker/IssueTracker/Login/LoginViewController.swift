//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var warningView: BorderView!
    @IBOutlet weak var signInStackView: UIStackView!
    @IBOutlet weak var userNameInputView: InputStackView!
    @IBOutlet weak var passwordInputView: InputStackView!
    @IBOutlet weak var signInButton: BorderButton!
    @IBOutlet weak var signUpButton: BorderButton!
    
    // MARK: - Properties
    private var signInViewModel: SignInViewModel?
    private var isKeyboardShown = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        signUpButtonBinding()
    }
    
    // MARK: - Methods
    private func setUp() {
        setUpSignInViewModel()
        setUpObservers()
        setUpInputViews()
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
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setUpInputViews() {
        userNameInputView.inputTextField.returnKeyType = .next
        passwordInputView.inputTextField.returnKeyType = .done
        userNameInputView.inputTextField.delegate = self
        passwordInputView.inputTextField.delegate = self
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
        guard let id = signInViewModel?.userName.value,
            let password = signInViewModel?.password.value else { return }
        let body = UserCertification(userName: id, password: password)
        NetworkManager.request(url: EndPoint(path: .localLogin).url, method: .post, body: body, statusCodeRange: 200...299, decodable: SignInResponse.self, successHandler: { [unowned self] response in
            if response.status {
                NetworkManager.token = response.jwtToken
                guard let issueListViewController = self.storyboard?.instantiateViewController(withIdentifier: IssueListViewController.identifier) else { return }
                issueListViewController.modalPresentationStyle = .fullScreen
                self.present(issueListViewController, animated: true)
            } else {
                UIView.animate(withDuration: 0.75,
                               delay: 0,
                               options: .allowUserInteraction,
                               animations: {
                                self.warningView.alpha = 1
                                self.warningView.isHidden = false })
            }
        }, failHandler: { [unowned self] error in
            self.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none])
        })
        
        
    }
    
    @IBAction func githubLoginButtonTapped(_ sender: UIButton) {
        let loginEndPoint = EndPoint(path: .githubLogin).url
        OAuthManager(presentationContextProvider: self).reqeustToken(url: loginEndPoint, handler: { result in
            switch result {
            case .success(let token):
                NetworkManager.token = token
            case .failure(let error):
                self.alert(title: "에러 발생", message: error.message, actions: ["닫기" : nil])
            }
        })
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let signupViewController = storyboard?.instantiateViewController(identifier: SignUpViewController.identifier) as? SignUpViewController else { return }
        signupViewController.successHandler = { [unowned self] in
            self.alert(title: "회원가입 성공!", message: "회원가입이 완료되었습니다.", actions: ["닫기": .none])
        }
        present(signupViewController, animated: true)
    }
    
    // MARK: - Objc
    @objc func keyboardWillAppear(_ notification: Notification) {
        guard !isKeyboardShown else {
            isKeyboardShown = true
            return
        }
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let signUpButtonY = signUpButton.convert(view.frame.origin, to: view).y
        let move = -(keyboardSize.height - (view.frame.height - signUpButtonY))
        view.transform = CGAffineTransform(translationX: 0, y: move)
        
        isKeyboardShown.toggle()
    }
    
    @objc func keyboardWillDisappear() {
        view.transform = .identity
        isKeyboardShown = false
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let actions: [UIReturnKeyType : () -> ()] = [
            .done : {[unowned self] in
                self.view.endEditing(true)
            },
            .next : {[unowned self] in
                self.passwordInputView.inputTextField.becomeFirstResponder()
            }
        ]
        
        guard let action = actions[textField.returnKeyType] else {return true}
        action()
        return true
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
