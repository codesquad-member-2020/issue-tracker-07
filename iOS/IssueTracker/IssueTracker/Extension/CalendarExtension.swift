//
//  CalendarExtension.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/16.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

extension Calendar {
    func leftTime(date: Date) -> String{
        let offsetComps = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date, to: Date())
        if case let (d?, h?, m?, s?) = (offsetComps.day ,offsetComps.hour, offsetComps.minute, offsetComps.second) {
            if d > 0 {
                return "\(d)d"
            } else if h > 0 {
                return "\(h)h"
            } else if m > 0 && m < 60 {
                return "\(m)m"
            } else if s > 5 && s < 60 {
                return "\(s)s"
            } else {
                return "just now"
            }
        }
        return ""
    }
}
