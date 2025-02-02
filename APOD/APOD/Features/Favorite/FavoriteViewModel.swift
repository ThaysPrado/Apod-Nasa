//
//  FavoriteViewModel.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import Foundation
import Combine

class FavoriteViewModel: ObservableObject {
    @Published var apods: [Apod]?
    @Published var status: Status = .initial
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: ApodRepositoryProtocol

    init(repository: ApodRepositoryProtocol = ApodRepository()) {
        self.repository = repository
    }

    func fetchAll() {
        self.status = .loading
        do {
            self.apods = try repository.fetchAll()
            self.status = .success
        } catch {
            self.status = .failure
        }
    }
    
    func delete(byDate date: String) -> Bool {
        do {
            try repository.delete(byDate: date)
            return true
        } catch {
            return false
        }
    }

}
