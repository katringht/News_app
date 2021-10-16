//
//  FetchResult.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 16.10.2021.
//

import Foundation
import CoreData

func fetchResult() -> NSFetchedResultsController<NSFetchRequestResult>{
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    
    return frc
}
