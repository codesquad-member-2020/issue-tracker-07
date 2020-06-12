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
    var signUpInfo: SignUpInfo = .init() {
        didSet {
            isUserNameValid.value = signUpInfo.userNameIsValid()
            isPasswordValid.value = signUpInfo.passwordIsValid()
            isConfirmPasswordValid.value = signUpInfo.confirmPasswordIsValid()
            isEnabled.value = signUpInfo.signUpInfoIsValid()
        }
    }
    var isUserNameValid: Dynamic<Bool?> = .init(nil)
    var isPasswordValid: Dynamic<Bool?> = .init(nil)
    var isConfirmPasswordValid: Dynamic<Bool?> = .init(nil)
    var isEnabled: Dynamic<Bool> = .init(false)
}
