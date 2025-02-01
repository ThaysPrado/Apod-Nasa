//
//  APODRepository.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import CoreData
import Foundation

final class ApodRepository {

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
        item.thumbnail = ""

        saveContext()
    }

    func fetchAll() throws -> [Apod] {
        let fetchRequest: NSFetchRequest<ApodItem> = ApodItem.fetchRequest()
        let items = try context.fetch(fetchRequest)

        return items.map { item in
            Apod(
                copyright: item.copyright ?? "",
                date: item.date ?? "",
                explanation: item.explanation ?? "",
                mediaType: Apod.MediaType(rawValue: item.mediaType ?? "") ?? .image,
                title: item.title ?? "",
                url: item.url ?? ""
            )
        }
    }

    func fetch(byDate date: String) throws -> Apod? {
        let fetchRequest: NSFetchRequest<ApodItem> = ApodItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)

        if let picture = try context.fetch(fetchRequest).first {
            return Apod(
                copyright: picture.copyright ?? "",
                date: picture.date ?? "",
                explanation: picture.explanation ?? "",
                mediaType: Apod.MediaType(rawValue: picture.mediaType ?? "") ?? .image,
                title: picture.title ?? "",
                url: picture.url ?? ""
            )
        }
        return nil
    }

    func delete(byDate date: String) throws {
        let fetchRequest: NSFetchRequest<ApodItem> = ApodItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)

        if let picture = try context.fetch(fetchRequest).first {
            context.delete(picture)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Erro ao salvar no Core Data: \(error)")
        }
    }
}
