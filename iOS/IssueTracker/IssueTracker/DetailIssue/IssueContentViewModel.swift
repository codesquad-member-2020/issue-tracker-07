//
//  IssueContentViewModel.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

protocol Contentable {
    var authorName: String? { get set }
    var imageURL: String? { get set }
    var reportingDate: String { get set }
    var content: String? { get set }
}

class IssueContentViewModel {
    
    var authorName: Dynamic<String?>
    var imageURL: Dynamic<String?>
    var reportingDate: Dynamic<String?>
    var content: Dynamic<String?>
    
    init(content: Contentable?) {
        self.authorName = .init(content?.authorName)
        self.imageURL = .init(content?.imageURL)
        self.reportingDate = .init(content?.reportingDate)
        self.content = .init(content?.content)
    }
}
