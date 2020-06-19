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
    @IBOutlet weak var IDInputView: InputStackView!
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
        IDInputView.bind { [unowned self] userName in
            self.signInViewModel?.signInInfo.userName = userName
        }
        passwordInputView.bind { [unowned self] password in
            self.signInViewModel?.signInInfo.password = password
        }
    }
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setUpInputViews() {
        IDInputView.inputTextField.returnKeyType = .next
        passwordInputView.inputTextField.returnKeyType = .done
        IDInputView.inputTextField.delegate = self
        passwordInputView.inputTextField.delegate = self
    }
    
    private func signUpButtonBinding() {
        signInViewModel?.isEnabled.bind { [unowned self] isEnabled in
            self.signInButton.isEnabled = isEnabled
            UIView.animate(withDuration: 0.5, animations: {
                self.signInButton.alpha = isEnabled ? 1 : 0.5
            })
        }
        signInViewModel?.isEnabled.fire()
    }
    
    private func presentIssueListViewController() {
        guard let tabbarController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") else { return }
        tabbarController.modalPresentationStyle = .fullScreen
        self.present(tabbarController, animated: true)
    }
    
    private func showWarningView() {
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       options: .allowUserInteraction,
                       animations: {
                        self.warningView.alpha = 1
                        self.warningView.isHidden = false })
    }
    
    // MARK: - Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
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
        SignInUseCase().signIn(networkManager: NetworkManager(),
                                      userName: signInViewModel?.signInInfo.userName,
                                      password: signInViewModel?.signInInfo.password,
                                      successHandler: { [unowned self] response in
                                        NetworkManager.token = response.jwtToken
                                        response.status ? self.presentIssueListViewController() : self.showWarningView() },
                                      failHandler: { [unowned self] error in
                                        let alert = UIAlertController.alert(title: "에러 발생", message: error.localizedDescription, actions: ["닫기": .none])
                                        self.present(alert, animated: true)
        })
    }
    
    @IBAction func githubLoginButtonTapped(_ sender: UIButton) {
        let loginEndPoint = EndPoint(path: .githubLogin).url
        OAuthManager(presentationContextProvider: self).reqeustToken(url: loginEndPoint, handler: { result in
            switch result {
            case .success(let token):
                NetworkManager.token = token
                self.presentIssueListViewController()
            case .failure(let error):
                let alert = UIAlertController.alert(title: "에러 발생", message: error.message, actions: ["닫기" : nil])
                self.present(alert, animated: true)
            }
        })
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        let appleIdRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleIdRequest.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [appleIdRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let signupViewController = storyboard?.instantiateViewController(identifier: SignUpViewController.identifier) as? SignUpViewController else { return }
        signupViewController.successHandler = { [unowned self] in
            let alert = UIAlertController.alert(title: "회원가입 성공!", message: "회원가입이 완료되었습니다.", actions: ["닫기": .none])
            self.present(alert, animated: true)
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
        
        guard let action = actions[textField.returnKeyType] else { return true }
        action()
        return true
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding,  ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        let userEmail = credential.email ?? ""
        let fullName = ((credential.fullName?.familyName ?? "") + (credential.fullName?.givenName ?? ""))
        SignInUseCase().signInWithApple(networkManager: NetworkManager(),
                                        name: fullName,
                                        email: userEmail,
                                        successHandler: { response in
                                            NetworkManager.token = response.jwtToken
                                            self.presentIssueListViewController() },
                                        failHandler: { [unowned self] error in
                                            let alert = UIAlertController.alert(title: "에러 발생",
                                                                                message: error.localizedDescription,
                                                                                actions: ["닫기": .none])
                                            self.present(alert, animated: true)
        })
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController.alert(title: "에러 발생",
                                            message: error.localizedDescription,
                                            actions: ["닫기": .none])
        present(alert, animated: true)
    }
}
