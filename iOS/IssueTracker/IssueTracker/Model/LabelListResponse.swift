//
//  LabelListResponse.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct LabelListResponse: Codable {
    
    var status: Bool
    var label: [Label]
}
