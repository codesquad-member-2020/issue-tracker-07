//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - Properties
    static var token: String?
    
    // MARK: - Methods
    static func request<D, E>(url: URL?, method: HTTPMethod = .get, body: E? = nil, statusCodeRange: ClosedRange<Int> = 200...299, decodable: D.Type, successHandler: @escaping (D) -> (), failHandler: @escaping (AFError) -> ())
        where D: Decodable, E: Codable {
            guard let url = url else { return }
            AF.request(url, method: method, parameters: body, encoder: JSONParameterEncoder.default)
                .validate(statusCode: statusCodeRange)
                .responseDecodable(of: decodable, decoder: JSONDecoder()) { response in
                    switch response.result {
                    case .success(let model):
                        successHandler(model)
                    case .failure(let error):
                        failHandler(error)
                    }
            }
    }
}
