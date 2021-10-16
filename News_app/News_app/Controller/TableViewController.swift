//
//  TableViewController.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 26.04.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let fetchservice = Fetch_UpdateService()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Geopolitical News"
        updateTableView()
    }
    
    func updateTableView() {
        fetchservice.updateTable(self)
        fetchservice.fetchedhResultController.delegate = self
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchservice.fetchedhResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! TableViewCell
        
        if let news = fetchservice.fetchedhResultController.object(at: indexPath) as? News {
            DispatchQueue.main.async {
                cell.title.text = news.title?.uppercased()
                cell.subtitle.text = news.body
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if let news = fetchservice.fetchedhResultController.object(at: indexPath) as? News {
            vc.detailItem.text = news.title?.uppercased()
            vc.detailBodyItem.text = news.body
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
