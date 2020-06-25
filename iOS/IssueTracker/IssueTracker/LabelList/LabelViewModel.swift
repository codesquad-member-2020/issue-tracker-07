//
//  LabelViewModel.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelViewModel {
    
    var title: Dynamic<String?>
    var backgroundColor: Dynamic<UIColor?>
    var description: Dynamic<String?>
    
    init(label: Label?) {
        title = Dynamic(label?.title)
        backgroundColor = Dynamic(UIColor.init(hex: label?.backgroundColor))
        description = Dynamic(label?.description)
    }
}
