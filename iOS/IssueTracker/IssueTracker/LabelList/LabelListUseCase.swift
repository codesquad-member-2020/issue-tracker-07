//
//  LabelListUseCase.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct LabelListUseCase {
    
    func request(sucessHandler: @escaping ([Label]) -> (), failureHandler: @escaping (Error) -> ()) {
        let requestComponents = RequestComponents(url: EndPoint(path: .labelList).url, method: .get, body: EmptyBody())
        let responseComponents = ResponseComponents(statusCodeRange: 200...299, decodableType: [Label].self)
        NetworkManager().request(requestComponents: requestComponents,
                                 responseComponents: responseComponents,
                                 successHandler: sucessHandler,
                                 failHandler: failureHandler)
    }
}
