//
//  OriginData.swift
//  iOSNiubizIntegration
//
//  Created by Joseph on 6/05/21.
//

import Alamofire


struct Service {
    static func getStringData(parametros: [String: Any] = [:],
                              completion: @escaping(Swift.Result<String, Error>) -> ()) {
        let headers: HTTPHeaders = [
            .authorization(username: "integraciones@niubiz.com.pe", password: "_7z3@8fF")
        ]
        AF.request("https://apisandbox.vnforappstest.com/api.security/v1/security",
                   method: .post,
                   parameters: nil,
                   headers: headers,
                   requestModifier: nil)
            .validate().responseString { response in
                switch response.result {
                case .success(let token):
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
