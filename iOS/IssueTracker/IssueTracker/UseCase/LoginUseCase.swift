//
//  LoginUseCase.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct LoginUseCase {
    
    // MARK: - Methods
    func loginFail(handler: @escaping (Bool) -> ()) {
        handler(false)
    }
    
    func loginSuccess(handler: @escaping (Bool) -> ()) {
        handler(true)
    }
}
