//
//  TableViewController.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 26.04.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
         frc.delegate = self
        tableView.reloadData()
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Geopolitical News"
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: self.fetchedhResultController.sections?[0].numberOfObjects))")
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        let service = NetworkingService.shared
        service.getDataWith { (result) in
            switch result{
            case .Success(let data):
                self.clearData()
                self.saveInCoreDataWith(array: data)
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showError()
                    print(message)
                }
            }
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func createNewsEntityFrom(dictionary : [String: AnyObject]) -> NSManagedObject? {
        let context = PersistenceService.shared.persistentContainer.viewContext
        
        if let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as? News {
            newsEntity.title = dictionary["title"] as? String
            newsEntity.body = dictionary["body"] as? String
            return newsEntity
            
        }
        return nil
    }
    
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createNewsEntityFrom(dictionary: $0)}
        do {
            try PersistenceService.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
    private func clearData() {
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
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.fetchedhResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        
        if let news = fetchedhResultController.object(at: indexPath) as? News {
            DispatchQueue.main.async {
                cell.textLabel?.text = news.title?.uppercased()
                cell.detailTextLabel?.text = news.body
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
//        vc.detailItem = petitions[indexPath.row]
//        if let news = fetchedhResultController.object(at: indexPath) as? News {
//                vc.detailItem?.text = news.title?.uppercased()
////                cell.detailTextLabel?.text = news.body
////                vc.detailItem = news.title
//        }
        vc.detailItem = "gg"
        navigationController?.pushViewController(vc, animated: true)
    }
}
