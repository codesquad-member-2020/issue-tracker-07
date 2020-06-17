//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManageable {
    func request<D, E>(requestComponents: RequestComponents<E>, responseComponents: ResponseComponents<D>, successHandler: @escaping (D) -> (), failHandler: @escaping (AFError) -> ())
    where D: Decodable, E: Codable
}

final class NetworkManager: NetworkManageable {
    
    // MARK: - Properties
    static var token: String?
    
    // MARK: - Methods
    func request<D, E>(requestComponents: RequestComponents<E>, responseComponents: ResponseComponents<D>, successHandler: @escaping (D) -> (), failHandler: @escaping (AFError) -> ())
        where D: Decodable, E: Codable {
            guard let url = requestComponents.url else { return }
            var dataRequest: DataRequest
            if (requestComponents.body as? EmptyBody) != nil {
                dataRequest = AF.request(url, method: requestComponents.method)
            } else {
                dataRequest = AF.request(url, method: requestComponents.method, parameters: requestComponents.body, encoder: JSONParameterEncoder.default)
            }
            
            dataRequest
                .validate(statusCode: responseComponents.statusCodeRange)
                .responseDecodable(of: responseComponents.decodableType, decoder: JSONDecoder()) { response in
                    switch response.result {
                    case .success(let model):
                        successHandler(model)
                    case .failure(let error):
                        failHandler(error)
                    }
            }
    }
}
