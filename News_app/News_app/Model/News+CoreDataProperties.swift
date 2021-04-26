//
//  News+CoreDataProperties.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 26.04.2021.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension News : Identifiable {

}
