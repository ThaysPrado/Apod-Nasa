//
//  ApodService.swift
//  APOD
//
//  Created by Thays Prado on 29/01/25.
//

import Foundation

protocol ApodServiceProtocol {
    func getAPOD(_ date: Date?, _ completion: @escaping (Result<Apod, RequestError>) -> Void)
}

struct ApodService: ApodServiceProtocol {
    private let apiManager: APIRequestable
    
    init(apiManager: APIRequestable = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getAPOD(_ date: Date? = nil, _ completion: @escaping (Result<Apod, RequestError>) -> Void) {
        var queryParams = ["api_key": ServiceConfig.getApiKey()]
        
        if let date = date {
            queryParams["date"] = date.toString()
        }

        apiManager.request(
            url: NetworkConstants.URLs.baseURL,
            method: .get,
            headers: [:],
            queryParameters: queryParams,
            body: nil
        ) { (result: Result<Apod, RequestError>) in
            switch result {
            case .success(let apod):
                completion(.success(apod))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
