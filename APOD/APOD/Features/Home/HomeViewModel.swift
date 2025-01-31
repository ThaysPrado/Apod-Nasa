//
//  HomeViewModel.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var apod: Apod?
    @Published var errorMessage: String?

    private let service: ApodServiceProtocol

    init(service: ApodServiceProtocol = ApodService()) {
        self.service = service
    }

    func getAPOD() {
        service.getAPOD { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let apod):
                    self?.apod = apod
                case .failure(let error):
                    self?.errorMessage = "Failed to load APOD: \(error.localizedDescription)"
                }
            }
        }
    }
}
