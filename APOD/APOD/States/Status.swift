//
//  Status.swift
//  APOD
//
//  Created by Thays Prado on 31/01/25.
//

enum Status: Equatable {
    case initial
    case loading
    case success
    case failure

    var isInitial: Bool { self == .initial }
    var isLoading: Bool { self == .loading }
    var isSuccess: Bool { self == .success }
    var isFailure: Bool { self == .failure }
}
