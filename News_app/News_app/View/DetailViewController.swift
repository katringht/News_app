//
//  DetailViewController.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 26.04.2021.
//

import UIKit
class DetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupScrollView()
        setupView()
        
    }
    
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
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupView(){
        contentView.addSubview(detailItem)
        contentView.addSubview(detailBodyItem)
        
        detailItem.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        detailItem.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        detailItem.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4/5).isActive = true
        
        detailBodyItem.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        detailBodyItem.topAnchor.constraint(equalTo: detailItem.bottomAnchor, constant: 25).isActive = true
        detailBodyItem.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4/5).isActive = true
        detailBodyItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
