//
//  Dynamic.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

final class Dynamic<T> {
    typealias Handler = (T) -> ()
    private var handler: Handler?
    var value: T {
        didSet {
            handler?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ handler: Handler?) {
        self.handler = handler
    }
    
    func fire() {
        handler?(value)
    }
}
