//
//  UserCertification.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct UserCertification: Codable {
    let name: String?
    let id: String?
    let password: String?
    
    init(name: String? = nil, id: String?, password: String?) {
        self.name = name
        self.id = id
        self.password = password
    }
}
