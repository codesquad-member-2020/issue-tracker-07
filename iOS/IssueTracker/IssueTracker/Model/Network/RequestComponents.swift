//
//  RequestComponents.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/12.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import Alamofire

struct RequestComponents<T: Codable> {
    
    // MARK: - Properties
    let url: URL?
    let method: HTTPMethod
    let body: T?
    
    init(url: URL?, method: HTTPMethod, body: T?) {
        self.url = url
        self.method = method
        self.body = body
    }
}

struct EmptyBody: Codable { }
