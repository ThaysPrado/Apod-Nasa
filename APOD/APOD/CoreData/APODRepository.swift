//
//  APODRepository.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import CoreData
import Foundation

protocol ApodRepositoryProtocol {
    func save(_ apod: Apod) throws
    func fetchAll() throws -> [Apod]
    func fetch(byDate date: String) throws -> Apod?
    func delete(byDate date: String) throws
}

final class ApodRepository: ApodRepositoryProtocol {

    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController(modelName: "APOD").context) {
        self.context = context
    }

    func save(_ apod: Apod) throws {
        let item = ApodItem(context: context)
        item.copyright = apod.copyright
        item.date = apod.date
        item.explanation = apod.explanation
        item.mediaType = apod.mediaType.rawValue
        item.title = apod.title
        item.url = apod.url
        item.thumbnailUrl = apod.thumbnailUrl

        try saveContext()
    }
    
    private func mapToApod(_ item: ApodItem) -> Apod {
        return Apod(
            copyright: item.copyright,
            thumbnailUrl: item.thumbnailUrl,
            date: item.date ?? "",
            explanation: item.explanation ?? "",
            mediaType: Apod.MediaType(rawValue: item.mediaType ?? "image") ?? .image,
            title: item.title ?? "",
            url: item.url ?? ""
        )
    }
    
    func fetchAll() throws -> [Apod] {
        let fetchRequest: NSFetchRequest<ApodItem> = ApodItem.fetchRequest()
        return try context.fetch(fetchRequest).map { mapToApod($0) }
    }

    func fetch(byDate date: String) throws -> Apod? {
        let fetchRequest: NSFetchRequest<ApodItem> = ApodItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)
        return try context.fetch(fetchRequest).first.map { mapToApod($0) }
    }
    
    func delete(byDate date: String) throws {
        let fetchRequest: NSFetchRequest<ApodItem> = ApodItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)

        if let item = try context.fetch(fetchRequest).first {
            context.delete(item)
            try saveContext()
        }
    }
    
    private func saveContext() throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
}
