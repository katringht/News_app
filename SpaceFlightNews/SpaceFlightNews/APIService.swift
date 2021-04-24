//
//  APIService.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Tarasova on 24.04.2021.
//

import UIKit

class APIService: NSObject {
    
    lazy var endPoint: String = {
        return "https://www.spaceflightnewsapi.net/api/v2/articles"
    }()
    
    func getDataWith(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        guard let url = URL(string: endPoint) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return completion(.Error(error!.localizedDescription))}
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))}
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String: AnyObject]] {
                    
                    DispatchQueue.main.async {
                        completion(.Success(jsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
        }.resume()
    }
}


enum Result <T>{
    case Success(T)
    case Error(String)
}
