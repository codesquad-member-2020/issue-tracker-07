//
//  SignInUseCase.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/12.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SignInUseCase {
    
    func signIn(networkManager: NetworkManageable, userName: String?, password: String?, successHandler: @escaping (SignInResponse) -> (), failHandler: @escaping (Error) -> ()) {
        let body = UserCertification(id: userName, password: password)
        let requestComponents = RequestComponents(url: EndPoint(path: .localLogin).url, method: .post, body: body)
        let responseComponets = ResponseComponents(statusCodeRange: 200...299, decodableType: SignInResponse.self)
        networkManager.request(requestComponents: requestComponents,
                               responseComponents: responseComponets,
                               successHandler: successHandler,
                               failHandler: failHandler)
    }
    
    func signInWithApple(networkManager: NetworkManageable, name: String, email: String, successHandler: @escaping (SignInResponse) -> (), failHandler: @escaping (Error) -> ()) {
        let body = AppleLoginCertification(id: email, name: name)
        let requestComponents = RequestComponents(url: EndPoint(path: .appleLogin).url, method: .post, body: body)
        let responseComponets = ResponseComponents(statusCodeRange: 200...299, decodableType: SignInResponse.self)
        networkManager.request(requestComponents: requestComponents,
                               responseComponents: responseComponets,
                               successHandler: successHandler,
                               failHandler: failHandler)
    }
}
