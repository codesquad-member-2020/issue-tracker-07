//
//  DateFormatterExtension.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/16.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

extension DateFormatter {
    var dateConverter: DateFormatter {
        dateFormat = "yyyy-MM-dd"
        calendar = .current
        return self
    }
}
