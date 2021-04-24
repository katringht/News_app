//
//  News+CoreDataProperties.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Tarasova on 24.04.2021.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?

}

extension News : Identifiable {

}
