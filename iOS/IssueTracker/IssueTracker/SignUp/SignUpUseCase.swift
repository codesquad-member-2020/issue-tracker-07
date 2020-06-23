//
//  SignUpUseCase.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/12.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SignUpUseCase {
    
    func createAccount(networkManager: NetworkManageable, name: String?, id: String?, password: String?, successHandler: @escaping (SignUpResponse) -> (), failHandler: @escaping (Error) -> ()) {
        let body = UserCertification(name: name, id: id, password: password)
        let requestComponents = RequestComponents(url: EndPoint(path: .signUp).url, method: .post, body: body)
        let responseComponets = ResponseComponents(statusCodeRange: 200...299, decodableType: SignUpResponse.self)
        networkManager.request(requestComponents: requestComponents,
                               responseComponents: responseComponets,
                               successHandler: successHandler,
                               failHandler: failHandler)
    }
}


