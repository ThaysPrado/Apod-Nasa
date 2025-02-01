//
//  HomeViewModel.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var apod: Apod?
    @Published var errorMessage: String?
    @Published var status: Status = .initial
    
    private var cancellables = Set<AnyCancellable>()
    private let service: ApodServiceProtocol

    init(service: ApodServiceProtocol = ApodService()) {
        self.service = service
        
        $selectedDate
            .sink { date in
                self.getAPOD(date)
            }
            .store(in: &cancellables)
    }

    func getAPOD(_ date: Date? = nil) {
        self.status = .loading
        
        service.getAPOD(date) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let apod):
                    self?.apod = apod
                    self?.errorMessage = nil
                    self?.status = .success
                case .failure(let error):
                    self?.apod = nil
                    self?.errorMessage = error.getMessage()
                    self?.status = .failure
                }
            }
        }
    }
}
