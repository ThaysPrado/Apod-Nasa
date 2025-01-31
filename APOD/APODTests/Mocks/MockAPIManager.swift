//
//  MockAPIManager.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import Foundation

class MockAPIManager: APIRequestable {
    var responseResult: Any?

    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        queryParameters: [String: String]?,
        body: (any Encodable)?,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        if let result = responseResult as? Result<T, RequestError> {
            completion(result)
        } else {
            completion(.failure(.unknownStatusCode(-1)))
        }
    }
}
