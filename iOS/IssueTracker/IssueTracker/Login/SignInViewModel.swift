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
    
    init() {
        userName.bind { [unowned self] _ in
            self.isEnabled.value = self.validation()
        }
        password.bind { [unowned self] _ in
            self.isEnabled.value = self.validation()
        }
    }
    
    func validation() -> Bool {
        return userName.value?.isEmpty == false && password.value?.isEmpty == false
    }
}
