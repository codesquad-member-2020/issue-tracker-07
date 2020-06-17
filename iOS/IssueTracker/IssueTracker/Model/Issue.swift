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
    var contents: String?
    var isOpen: Bool
    var reportingDate: String
    var mileStone: MileStone?
    var labelList: [Label]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case contents = "description"
        case isOpen
        case reportingDate = "createdAt"
        case mileStone
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
