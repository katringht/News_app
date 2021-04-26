//
//  DetailViewController.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 26.04.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
//    let detailItem: UILabel = {
//        let label = UILabel()
//        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.lineBreakMode = .byWordWrapping
//        return label
//    }()
    var detailItem: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        title = detailItem
        
        
    }
    


}
