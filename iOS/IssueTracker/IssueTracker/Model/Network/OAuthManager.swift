//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/10.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import AuthenticationServices

enum OAuthError: Error {
    case invalidURL
    case tokenNotFound
    case defaultError(String?)
    
    var message: String? {
        switch self {
        case .invalidURL:
            return "잘못된 URL 입니다."
        case .tokenNotFound:
            return "토큰을 찾을 수 없습니다."
        case .defaultError(let msg):
            return msg
        }
    }
}

final class OAuthManager {
    
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
    func reqeustToken(url: URL?, handler: @escaping (Result<String, OAuthError>) -> ()) {
        guard let url = url else {
            handler(.failure(.invalidURL))
            return
        }
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme, completionHandler: { url, error in
            guard error == nil, let callbackURL = url else {
                handler(.failure(.defaultError(error?.localizedDescription)))
                return
            }
            
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            
            guard let token = queryItems?.filter({ $0.name == self.tokenQuery }).first?.value else {
                handler(.failure(.tokenNotFound))
                return
            }
            
            handler(.success(token))
        })
        
        session.presentationContextProvider = presentationContextProvider
        session.start()
    }
}
