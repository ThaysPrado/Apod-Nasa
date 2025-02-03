//
//  APIManager.swift
//  APOD
//
//  Created by Thays Prado on 29/01/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPHeader: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

protocol APIRequestable {
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        queryParameters: [String: String]?,
        body: Encodable?,
        completion: @escaping (Result<T, RequestError>) -> Void
    )
}

struct APIManager: APIRequestable {
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String]?,
        queryParameters: [String: String]? = nil,
        body: Encodable? = nil,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.unknownStatusCode(-1)))
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        headers?.forEach { field, value in
            request.setValue(value, forHTTPHeaderField: field)
        }
        
        if let body = body {
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: HTTPHeader.contentType.rawValue)
            } catch {
                completion(.failure(.encodingError))
                return
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownStatusCode(-1)))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            if (400...599).contains(statusCode) {
                completion(.failure(RequestError(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        dataTask.resume()
    }
}
