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
    @Published var errorMessage: String?
    @Published var status: Status = .initial
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: ApodRepository

    init(repository: ApodRepository = ApodRepository()) {
        self.repository = repository
    }

    func fetchAll() {
        self.status = .loading
        do {
            self.apods = try repository.fetchAll()
            self.status = .success
        } catch {
            self.status = .failure
            self.errorMessage = "\(error.localizedDescription)"
        }
    }
    
    func delete(byDate date: String) {
        do {
            try repository.delete(byDate: date)
        } catch {
            // TODO: Show erro
            print("Erro ao salvar no Core Data: \(error)")
        }
    }

}
