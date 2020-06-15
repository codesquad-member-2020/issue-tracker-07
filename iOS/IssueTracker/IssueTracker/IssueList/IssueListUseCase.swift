//
//  IssueListUseCase.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/15.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct IssueListUseCase {
    
    func mockLoadIssueListSueccess(successHandler: @escaping ([Issue]) -> ()) {
        let iOSLabel = Label(id: 0, title: "iOS", backgroundColor: "#5a8da2")
        let featureLabel = Label(id: 1, title: "feature", backgroundColor: "#F800A9")
        let scrumLabel = Label(id: 1, title: "scrum", backgroundColor: "#E7C6AA")
        let mileStone = MileStone(id: 0, title: "안하면 큰일남;")
        let issues = (0...5).reduce(into: [Issue]()) { issues, _ in
            issues.append(contentsOf: [Issue(id: 0,
                                             title: "VibrationTextField 구현",
                                             description: "좌우로 1초간 흔들리는 애니메이션 구현",
                                             isOpen: true,
                                             mileStone: nil,
                                             labels: [iOSLabel, featureLabel]),
                                       Issue(id: 1,
                                             title: "2020.06.20",
                                             description: "오늘 할 일\n카트하기\n잠 푹자기",
                                             isOpen: false,
                                             mileStone: mileStone,
                                             labels: [iOSLabel, scrumLabel])])
        }
        successHandler(issues)
    }
}