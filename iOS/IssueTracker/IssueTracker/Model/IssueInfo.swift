//
//  IssueInfo.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct IssueInfo: Codable {
    var id: Int
    var title: String
    var isOpen: Bool
    var milestone: [MileStone]
    var label: [Label]
    var assignee: [Assignee]
    var comments: [Comment]
}

struct Comment: Codable {
    var id: Int
    var authorName: String?
    var imageURL: String?
    var content: String?
    var reportingDate: String
    var modifiedDate: String
    var emoji: [Emoji]
    
    enum CodingKeys: String, CodingKey {
        case id
        case authorName = "writer"
        case imageURL = "imageUrl"
        case content
        case reportingDate = "createdAt"
        case modifiedDate = "modifiedAt"
        case emoji
    }
}

struct Emoji: Codable {
    var id: Int
    var unicode: String
    var clickCount: Int
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
