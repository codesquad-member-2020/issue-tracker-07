//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/16.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

final class IssueViewModel {
    var isOpen: Dynamic<Bool>
    var title: Dynamic<String>
    var number: Dynamic<Int>
    var description: Dynamic<String?>
    var mileStone: Dynamic<String?>
    
    init(issue: Issue) {
        isOpen = .init(issue.isOpen)
        title = .init(issue.title)
        number = .init(issue.id)
        description = .init(issue.description)
        mileStone = .init(issue.mileStone?.title)
    }
}
