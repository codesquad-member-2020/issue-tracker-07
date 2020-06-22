//
//  IssueInfo.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct IssueInfo: Codable {
    var contents: [Issue]
    var emoji: [Emoji]
    var comment: [Comment]
    var assignee: [Assignee]
}

struct Emoji: Codable {
    var id: Int
    var unicode: String
    var clickCount: Int
}

struct Comment: Codable {
    var id: Int
    var writer: String
    var imageURL: String
    var content: String
    var reportingDate: String
    var modifiedDate: String
    var emoji: [Emoji]
    
    enum CodingKeys: String, CodingKey {
        case id
        case writer
        case imageURL = "imageUrl"
        case content
        case reportingDate = "createdAt"
        case modifiedDate = "modifiedAt"
        case emoji
    }
}

struct Assignee: Codable {
    var id: Int
    var name: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
    }
}
