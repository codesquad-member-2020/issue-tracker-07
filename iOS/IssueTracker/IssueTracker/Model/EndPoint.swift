//
//  EndPoint.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/10.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct EndPoint {
    
    enum Path: CustomStringConvertible {
        case githubLogin
        case signUp
        
        var description: String {
            switch self {
            case .githubLogin:
                return "/api/login/github"
            case .signUp:
                return "/api/signup"
            }
        }
    }
    
    // MARK: - Properties
    private let scheme: String = "http"
    private let host: String = "3.34.77.7"
    let path: Path
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.description
        
        return components.url
    }
}
