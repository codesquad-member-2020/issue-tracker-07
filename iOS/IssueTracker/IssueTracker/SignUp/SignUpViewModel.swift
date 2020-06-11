//
//  SignUpViewModel.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

final class SignUpViewModel {
    
    // MARK: - Properties
    var userName: Dynamic<String?> = .init(nil)
    var password: Dynamic<String?> = .init(nil)
    var confirmPassword: Dynamic<String?> = .init(nil)
    var isEnabled: Dynamic<Bool> = .init(false)
    var isUserNameValid: Dynamic<Bool> = .init(false)
    var isPasswordValid: Dynamic<Bool> = .init(false)
    var isConfirmPasswordValid: Dynamic<Bool> = .init(false)
    
    // MARK: - LifeCycle
    init() {
        setUpBinding()
    }
    
    // MARK: - Methods
    // MARK: SetUp
    private func setUpBinding() {
        bindUserName()
        bindPassword()
        bindConfirmPassword()
    }
    
    private func bindUserName() {
        userName.bind { [unowned self] userName in
            guard let userName = userName else { return }
            self.isUserNameValid.value = (6...12) ~= userName.count
            self.validation()
        }
    }
    
    private func bindPassword() {
        password.bind { [unowned self] password in
            guard let password = password else { return }
            self.isPasswordValid.value = (6...12) ~= password.count
            self.validation()
        }
    }
    
    private func bindConfirmPassword() {
        confirmPassword.bind { [unowned self] confirmPassword in
            guard let confirmPassword = confirmPassword else { return }
            self.isConfirmPasswordValid.value = (self.password.value == confirmPassword)
            self.validation()
        }
    }
    
    private func validation() {
        isEnabled.value = isUserNameValid.value && isPasswordValid.value && isConfirmPasswordValid.value
    }
}
