//
//  SignInInfo.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/12.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SignInInfo {
    
    // MARK: - Properties
    var userName: String?
    var password: String?
    
    // MARK: - Methods
    func validation() -> Bool {
        guard let userName = userName,
            let password = password else { return false }
        let idValidation = (6...12) ~= userName.count
        let passwordValidation = (6...12) ~= password.count
        
        return idValidation && passwordValidation
    }
}
