//
//  ViewController.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Tarasova on 19.04.2021.
//

import UIKit

class NewsCollectionView: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        title = "Space Flight News"
        
        navigationController?.hidesBarsOnSwipe = true
    }


}

// MARK: Collection View Extension

extension UIViewController: UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("u tapped me")
    }
}
extension UIViewController: UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCells
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}



