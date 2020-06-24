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
    
    init(issueInfo: IssueInfo?) {
        id = .init(issueInfo?.id)
        title = .init(issueInfo?.title)
        authorName = .init(issueInfo?.comments.first?.authorName)
        imageURL = .init(issueInfo?.comments.first?.imageURL)
        isOpen = .init(issueInfo?.isOpen)
    }
}
