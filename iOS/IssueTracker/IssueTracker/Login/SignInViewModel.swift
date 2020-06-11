//
//  SignInViewModel.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class SignInViewModel {
    
    // MARK: - Properties
    var userName: Dynamic<String?> = .init(nil)
    var password: Dynamic<String?> = .init(nil)
    var isEnabled: Dynamic<Bool> = .init(false)
    
    // MARK: - LifeCycle
    init() {
        userName.bind { [unowned self] _ in
            self.isEnabled.value = self.validation()
        }
        password.bind { [unowned self] _ in
            self.isEnabled.value = self.validation()
        }
    }
    
    // MARK: - Methods
    private func validation() -> Bool {
        guard let userName = userName.value,
            let password = password.value else { return false }
        let idValidation = (6...12) ~= userName.count
        let passwordValidation = (6...12) ~= password.count
        
        return idValidation && passwordValidation
    }
}
