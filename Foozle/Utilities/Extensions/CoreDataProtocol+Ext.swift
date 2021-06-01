//
//  CoreDataProtocol+Ext.swift
//  Foozle
//
//  Created by Mike Conner on 5/31/21.
//

import SwiftUI
import CoreData

protocol AnyCollectionType {
    var backgroundImage: String { get }
    var name: String { get }
}

extension CollectionGame: AnyCollectionType {}
extension WishListGame: AnyCollectionType {}
