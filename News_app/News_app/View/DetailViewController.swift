//
//  DetailViewController.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 26.04.2021.
//

import UIKit
class DetailViewController: UIViewController {
    
    let detailItem: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let detailBodyItem: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Avenir Next Regular", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(detailItem)
        view.addSubview(detailBodyItem)
        self.view = view
        
        let margineGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            detailItem.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 0),
            detailItem.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
            detailItem.heightAnchor.constraint(equalToConstant: 200),
            detailItem.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor),
            
            detailBodyItem.topAnchor.constraint(equalTo: margineGuide.topAnchor),
            detailBodyItem.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
            detailBodyItem.bottomAnchor.constraint(equalTo: margineGuide.bottomAnchor, constant: 100),
            detailBodyItem.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
        ])
    }
}
