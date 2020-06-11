//
//  UserCertification.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct UserCertification: Codable {
    let userName: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "id"
        case password
    }
}
