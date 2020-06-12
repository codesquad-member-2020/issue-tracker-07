//
//  SignInViewModel.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

final class SignInViewModel {
    
    // MARK: - Properties
    var signInInfo: SignInInfo = .init() {
        didSet {
            isEnabled.value = signInInfo.validation()
        }
    }
    var isEnabled: Dynamic<Bool> = .init(false)
}
