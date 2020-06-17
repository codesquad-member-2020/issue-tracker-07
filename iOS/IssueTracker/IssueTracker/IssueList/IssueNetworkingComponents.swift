//
//  IssueNetworkingComponents.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/16.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct IssueListResponse: Codable {
    var status: Bool
    var issueList: [Issue]
    
    enum CodingKeys: String, CodingKey {
        case status
        case issueList = "issue"
    }
}

struct IssueStateRequest: Codable {
    var issueIdList: [Int]
    var state: String
}

struct IssueStatusResponse: Codable {
    var status: Bool
}

enum IssueState: CustomStringConvertible {
    case open
    case close
    
    var description: String {
        switch self {
        case .open:
            return "open"
        case .close:
            return "close"
        }
    }
}
