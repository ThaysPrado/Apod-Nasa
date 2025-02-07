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
    @Published var isFavoried: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let service: ApodServiceProtocol
    private let repository: ApodRepositoryProtocol

    init(service: ApodServiceProtocol = ApodService(), repository: ApodRepositoryProtocol = ApodRepository()) {
        self.service = service
        self.repository = repository
        
        $selectedDate
            .sink { [weak self] date in
                self?.getAPOD(date)
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
                    self?.isFavoried = self?.isFavorited(byDate: apod.date) ?? false
                    self?.status = .success
                case .failure(let error):
                    self?.apod = nil
                    self?.errorMessage = error.getMessage()
                    self?.status = .failure
                }
            }
        }
    }
    
    private func isFavorited(byDate date: String) -> Bool {
        do {
            let value = try repository.fetch(byDate: date)
            return value != nil
        } catch {
            return false
        }
    }
    
    func save() -> Bool {
        guard let apod = apod else {
            return false
        }
        do {
            let value = try repository.fetch(byDate: apod.date)
            if value == nil {
                try repository.save(apod)
            } else {
                try repository.delete(byDate: apod.date)
            }
            
            return true
        } catch {
           return false
        }
    }
}
