//
//  IssueTitleViewModel.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class IssueTitleViewModel {
    
    var id: Dynamic<Int?>
    var title: Dynamic<String?>
    var authorName: Dynamic<String?>
    var imageURL: Dynamic<String?>
    var isOpen: Dynamic<Bool?>
    
    init(issue: Issue?) {
        id = .init(issue?.id)
        title = .init(issue?.title)
        authorName = .init(issue?.authorName)
        imageURL = .init(issue?.imageURL)
        isOpen = .init(issue?.isOpen)
    }
}
