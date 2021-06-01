//
//  WishListGame+CoreDataProperties.swift
//  Foozle
//
//  Created by Mike Conner on 6/1/21.
//
//

import Foundation
import CoreData


extension WishListGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishListGame> {
        return NSFetchRequest<WishListGame>(entityName: "WishListGame")
    }

    @NSManaged public var backgroundImage: String
    @NSManaged public var descripitionRaw: String
    @NSManaged public var developers: String
    @NSManaged public var esrbRating: String
    @NSManaged public var genres: String
    @NSManaged public var uniqueID: UUID
    @NSManaged public var name: String
    @NSManaged public var platforms: String
    @NSManaged public var publishers: String
    @NSManaged public var released: String
    @NSManaged public var stores: String
    @NSManaged public var website: String

}

extension WishListGame : Identifiable {

}
