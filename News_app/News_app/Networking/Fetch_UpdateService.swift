//
//  Save_update_Service.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 16.10.2021.
//

import UIKit
import CoreData

class Fetch_UpdateService {
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func updateTable(_ vc: UIViewController) {
        do {
            try fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: fetchedhResultController.sections?[0].numberOfObjects))")
        } catch let error  {
            print("ERROR: \(error)")
        }
        let service = NetworkingService.shared
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):
                self.clearData()
                self.saveInCoreDataWith(array: data)
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showError(vc)
                    print(message)
                }
            }
        }
    }
    
    func showError(_ vc: UIViewController) {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(ac, animated: true)
    }
    
    func createNewsEntityFrom(dictionary : [String: AnyObject]) -> NSManagedObject? {
        let context = PersistenceService.shared.persistentContainer.viewContext
        
        if let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as? News {
            newsEntity.title = dictionary["title"] as? String
            newsEntity.body = dictionary["body"] as? String
            return newsEntity
        }
        return nil
    }
    
    func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createNewsEntityFrom(dictionary: $0)}
        do {
            try PersistenceService.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func clearData() {
        do {
            let context = PersistenceService.shared.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                PersistenceService.shared.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}
