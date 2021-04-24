//
//  ViewController.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Tarasova on 19.04.2021.
//

import UIKit
import CoreData

class NewsCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var  fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        // frc.delegate = self
        print("data fetched")
        return frc
    }()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        title = "Space Flight News"
        
        navigationController?.hidesBarsOnSwipe = true
        
        let service = APIService()
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):
                self.saveInCoreDataWith(array: data)
                print(data)
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Error", message: message)
                }
            }
        }
    }
    
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        for dict in array{
            _ = self.createNewsEntityFrom(dictionary: dict)
        }
        
        do{
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            print("data saved")
        } catch let error {
            print(error)
        }
    }
    
    private func createNewsEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject?{
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as? News{
            newsEntity.title = dictionary["title"] as? String
            newsEntity.imageUrl = dictionary["imageUrl"] as? String
            return newsEntity
        }
        return nil
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
//MARK: Collection View Methods
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("u tapped me")
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCells
        // i think dont work too
        if let news = fetchedResultController.object(at: indexPath) as? News{
            print("cellForItemAt - succed")
            cell.setNewsCellWith(news: news)
            
        } else {
            print("cellForItemAt - error")
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //dont work
        if let count = fetchedResultController.sections?.first?.numberOfObjects{
            print("numberOfItemsInSection - succed")
            return count
        } else {
            print("numberOfItemsInSection - error")
        }
        return 0
    }


}
