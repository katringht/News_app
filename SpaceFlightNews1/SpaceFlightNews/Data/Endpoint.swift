//
//  Endpoint.swift
//  SpaceFlightNews1
//
//  Created by Ekaterina Tarasova on 25.04.2021.
//

import Foundation
import CoreData

enum Endpoint<T: NSManagedObject> {
    case news
    
    var urlPath: String {
        switch self {
        case .news:
            return "https://www.spaceflightnewsapi.net/api/v2/articles"
        }
    }
}
