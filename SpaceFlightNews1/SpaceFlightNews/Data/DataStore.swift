//
//  DataStore.swift
//  SpaceFlightNews1
//
//  Created by Ekaterina Tarasova on 25.04.2021.
//

import Foundation
import CoreData

class DataStore: NSObject {
    let networking = NetworkingService.shared
    let persistence = PersistenceService.shared
    
    private override init(){
        super.init()
    }
    
    static let shared = DataStore()
    
    func requestNews(completion: @escaping ([News]) -> Void) {
        // go out to the internet
        
        networking.request("https://www.spaceflightnewsapi.net/api/v2/articles"){ [weak self] (result) in
            switch result {
            // get back some data
            case .success(let data):
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
                    
                    jsonArray.forEach {
                        guard
                            let strongSelf = self,
                            let title = $0["title"] as? String,
                            let image = $0["imageUrl"] as? String
                        else {return}
                        
                        let news = News(context: strongSelf.persistence.context)
                        news.title = title
                        news.imageUrl = image
                        
                    }
                    //save and fetch the data
                    DispatchQueue.main.async {
                        self?.persistence.save {
                            print("saved succeed")
                            self?.persistence.fetch(News.self, completion: { (obj) in
                                completion(obj)
                            })
                        }
                        
                    }
                }
                catch {
                    print(error)
                }
            case .failure(let error): print(error)
            }
        }
    }
}
