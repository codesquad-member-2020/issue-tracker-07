//
//  Issue.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/15.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct Issue: Codable {
    var id: Int
    var title: String
    var content: String?
    var authorName: String?
    var imageURL: String?
    var isOpen: Bool
    var reportingDate: String
    var modifiedDate: String?
    var milestone: [MileStone]
    var labelList: [Label]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content = "description"
        case authorName
        case imageURL = "imageUrl"
        case isOpen
        case reportingDate = "createdAt"
        case modifiedDate = "modifiedAt"
        case milestone
        case labelList = "label"
    }
}

struct MileStone: Codable {
    var id: Int
    var title: String
}

struct Label: Codable {
    var id: Int
    var title: String
    var backgroundColor: String
}
