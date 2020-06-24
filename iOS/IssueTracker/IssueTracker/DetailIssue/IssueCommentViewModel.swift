//
//  IssueContentViewModel.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class IssueCommentViewModel {
    
    var authorName: Dynamic<String?>
    var imageURL: Dynamic<String?>
    var reportingDate: Dynamic<String?>
    var content: Dynamic<String?>
    
    init(comment: Comment?) {
        self.authorName = .init(comment?.authorName)
        self.imageURL = .init(comment?.imageURL)
        self.reportingDate = .init(comment?.reportingDate)
        self.content = .init(comment?.content)
    }
}
