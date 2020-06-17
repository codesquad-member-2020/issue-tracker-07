//
//  IssueListUseCase.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/15.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct IssueListUseCase {
    
    func loadIssueList(networkManager: NetworkManageable, successHandler: @escaping ([Issue]) -> (), failHandler: @escaping (Error) -> ()) {
        let requestComponents = RequestComponents(url: EndPoint(path: .issueList).url, method: .get, body: EmptyBody())
        let responseComponents = ResponseComponents(statusCodeRange: 200...299, decodableType: IssueListResponse.self)
        networkManager.request(requestComponents: requestComponents,
                               responseComponents: responseComponents,
                               successHandler: { response in
                                successHandler(response.issueList)},
                               failHandler: failHandler)
    }
    
    func requestChangeIssuesState(networkManager: NetworkManageable, issueIds: [Int], state: IssueState, successHandler: @escaping (Bool) -> (), failHandler: @escaping (Error) -> ()) {
        let issueStateRequest = IssueStateRequest(issueIdList: issueIds, state: state.description)
        let requestComponents = RequestComponents(url: EndPoint(path: .issueList).url, method: .patch, body: issueStateRequest)
        print(requestComponents)
        let responseComponents = ResponseComponents(statusCodeRange: 200...299, decodableType: IssueStatusResponse.self)
        networkManager.request(requestComponents: requestComponents,
                               responseComponents: responseComponents,
                               successHandler: { response in
                                successHandler(response.status)},
                               failHandler: failHandler)
    }
    
    func mockRequestDeleteSuccess(successHandler: @escaping(Bool) -> ()) {
        successHandler(true)
    }
    
    func mockRequestCloseSuccess(successHandler: @escaping(Bool) -> ()) {
        successHandler(true)
    }
    
    func mockRequestOpenSuccess(successHandler: @escaping(Bool) -> ()) {
        successHandler(true)
    }
    
    func mockLoadIssueListSuccess(successHandler: @escaping ([Issue]) -> ()) {
        let iOSLabel = Label(id: 0, title: "iOS", backgroundColor: "#5a8da2")
        let featureLabel = Label(id: 1, title: "feature", backgroundColor: "#F800A9")
        let scrumLabel = Label(id: 1, title: "scrum", backgroundColor: "#E7C6AA")
        let mileStone = MileStone(id: 0, title: "안하면 큰일남;")
        let issues = (0...5).reduce(into: [Issue]()) { issues, _ in
            issues.append(contentsOf: [Issue(id: 0,
                                             title: "VibrationTextField 구현",
                                             contents: "좌우로 1초간 흔들리는 애니메이션 구현",
                                             isOpen: true,
                                             reportingDate: "2020-06-18",
                                             mileStone: nil,
                                             labelList: [iOSLabel, featureLabel]),
                                       Issue(id: 1,
                                             title: "2020.06.20",
                                             contents: "오늘 할 일\n카트하기\n잠 푹자기",
                                             isOpen: false,
                                             reportingDate: "2020-06-18",
                                             mileStone: mileStone,
                                             labelList: [iOSLabel, scrumLabel])])
        }
        successHandler(issues)
    }
}

