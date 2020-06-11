//
//  SignInResponse.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SignInResponse: Decodable {
    let status: Bool
    let jwtToken: String
}
