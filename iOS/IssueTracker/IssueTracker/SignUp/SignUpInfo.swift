//
//  SignUpInfo.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/12.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SignUpInfo {
    
    // MARK: - Properties
    var userName: String?
    var password: String?
    var confirmPassword: String?
    
    // MARK: - Methods
    func userNameIsValid() -> Bool? {
        guard let userName = userName else { return nil }
        return (6...12) ~= userName.count
    }
    
    func passwordIsValid() -> Bool? {
        guard let password = password else { return nil }
        return (6...12) ~= password.count
    }
    
    func confirmPasswordIsValid() -> Bool? {
        guard let confirmPassword = confirmPassword else { return nil }
        return password == confirmPassword
    }
    
    func signUpInfoIsValid() -> Bool {
        let userNameValidation = userNameIsValid() ?? false
        let passwordValidation = passwordIsValid() ?? false
        let confirmPasswordValidation = confirmPasswordIsValid() ?? false
        return userNameValidation && passwordValidation && confirmPasswordValidation
    }
}
