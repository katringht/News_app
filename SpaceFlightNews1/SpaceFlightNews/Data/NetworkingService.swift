//
//  NetworkingService.swift
//  SpaceFlightNews1
//
//  Created by Ekaterina Tarasova on 25.04.2021.
//

import Foundation

class NetworkingService {
    
    private init() {}
    static let shared = NetworkingService()
    
    func request(_ urlPath: String, completion: @escaping (Result<Data, NSError>) -> Void){
        let url = URL(string: urlPath)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            if let unwrappedError = error {
                completion(.failure(unwrappedError as NSError))
            } else if let unwrappedData = data {
                completion(.success(unwrappedData))
            }
        }
        task.resume()
    }
}
