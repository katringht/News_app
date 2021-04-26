//
//  ViewController.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Tarasova on 19.04.2021.
//

import UIKit
import CoreData

class NewsCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    let store = DataStore.shared
    
    var articleNews = [News]()
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//         frc.delegate = self
//        tableView.reloadData()
        return frc
    }()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Space Flight News"
        
        store.requestNews() { [weak self ] (news) in
            self?.articleNews = news
            self?.collectionView.reloadData()

        }
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: self.fetchedhResultController.sections?[0].numberOfObjects))")
        } catch let error  {
            print("ERROR: \(error)")
        }
//        let service = DataStore()
//        service.re { (result) in
//            switch result {
//            case .Success(let data):
//                self.clearData()
//                self.saveInCoreDataWith(array: data)
//            case .Error(let message):
//                DispatchQueue.main.async {
//                    self.showAlertWith(title: "Error", message: message)
//                }
//            }
//        }
        
    }
    
    //MARK: Collection View Methods
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("u tapped me")
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCells
        if let news = fetchedhResultController.object(at: indexPath) as? News {
            DispatchQueue.main.async {
                cell.setNewsCellWith(news: news)
            }
        } else {
            print("error1")
        }
        
//        let article = articleNews[indexPath.row]
//        cell.setNewsCellWith(news: article)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.fetchedhResultController.sections?[0].numberOfObjects {
            return count
        } else {
            print("error2")
        }
        return 0
    }
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return fetchedResultController.sections?.count ?? 0
    //    }
    
    
}
