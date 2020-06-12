//
//  ResponseComponents.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/12.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ResponseComponents<T: Decodable> {
    
    // MARK: - Properties
    let statusCodeRange: ClosedRange<Int>
    let decodableType: T.Type
}
