//
//  RequestError.swift
//  APOD
//
//  Created by Thays Prado on 29/01/25.
//

enum RequestError: Error, Equatable {
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case notAllowed
    case notAcceptable
    case timeout
    case tooManyRequests
    case internalError
    case badGateway
    case unavailable
    case notImplemented
    
    case unknownStatusCode(Int)
    case decodingError
    case encodingError
    case networkError
    
    init(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 401, 407:
            self = .unauthorized
        case 402:
            self = .paymentRequired
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405:
            self = .notAllowed
        case 406:
            self = .notAcceptable
        case 408, 504:
            self = .timeout
        case 429:
            self = .tooManyRequests
        case 500:
            self = .internalError
        case 501:
            self = .notImplemented
        case 502:
            self = .badGateway
        case 503:
            self = .unavailable
        default:
            self = .unknownStatusCode(statusCode)
        }
    }
    
    func getMessage() -> String {
        if self == .notFound {
            return String(localized: "ImageNotFoundMessage")
        }
        
        return String(localized: "GenericErrorMessage")
    }
    
    static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.badRequest, .badRequest),
             (.unauthorized, .unauthorized),
             (.paymentRequired, .paymentRequired),
             (.forbidden, .forbidden),
             (.notFound, .notFound),
             (.notAllowed, .notAllowed),
             (.notAcceptable, .notAcceptable),
             (.timeout, .timeout),
             (.tooManyRequests, .tooManyRequests),
             (.internalError, .internalError),
             (.badGateway, .badGateway),
             (.unavailable, .unavailable),
             (.notImplemented, .notImplemented),
             (.decodingError, .decodingError),
             (.encodingError, .encodingError),
             (.networkError, .networkError):
            return true
        case (.unknownStatusCode(let lhsCode), .unknownStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}
