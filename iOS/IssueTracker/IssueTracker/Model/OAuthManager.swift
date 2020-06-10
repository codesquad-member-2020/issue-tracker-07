//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/10.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import AuthenticationServices

class OAuthManager {
    
    // MARK: - Properties
    static var token: String?
    private let presentationContextProvider: ASWebAuthenticationPresentationContextProviding
    private let callbackScheme: String = "io.issuetracker.app"
    private let tokenQuery: String = "token"
    
    // MARK: - LifeCycle
    init(presentationContextProvider: ASWebAuthenticationPresentationContextProviding) {
        self.presentationContextProvider = presentationContextProvider
    }
    
    // MARK: - Methods
    func reqeustToken(url: URL?) {
        guard let url = url else {return}
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme, completionHandler: { url, error in
            guard error == nil, let callbackURL = url else {return}
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let token = queryItems?.filter({ $0.name == self.tokenQuery }).first?.value
            OAuthManager.token = token
        })
        
        session.presentationContextProvider = presentationContextProvider
        session.start()
    }
}
