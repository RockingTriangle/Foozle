//
//  CollectionViewGameData.swift
//  Foozle
//
//  Created by Mike Conner on 6/2/21.
//

import SwiftUI

struct CollectionViewGameData: Codable {
    
    let id: Int
    let name: String
    let slug: String
    let backgroundImage: String?
    let released: String?
    let platforms: [Platforms]
    let genres: [Genres]?
    let stores: [Stores]?
    let esrbRating: ESRBRating?
    let publishers: [Publisher]?
    let developers: [Developer]?
    let descriptionRaw: String
    let website: String
    
    lazy var isInCollection: Bool = false
    lazy var isOnWishList: Bool = false
    
    func displayBackgroundImage() -> String {
        backgroundImage != nil ? backgroundImage! : "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noImage.png"
    }
    
    func displayReleasedData() -> String {
        released != nil ? released! : "Not available"
    }
    
    func displayPlatformData() -> String {
        var platformString = ""
        for platform in platforms {
            platformString += platform.platform.name
            if platform.platform.id != platforms.last?.platform.id {
                platformString += ", "
            }
        }
        platformString = platformString.uppercased().replacingOccurrences(of: "PLAYSTATION", with: "PS")
        return platformString.uppercased()
    }
    
    func displayGenreData() -> String {
        var genresString = ""
        guard let gameGenres = genres, gameGenres.count != 0  else {
            return "Not available"
        }
        for genre in gameGenres {
            genresString += genre.name
            if genre.id != genres?.last?.id {
                genresString += ", "
            }
        }
        return genresString
    }
    
    func displayStoreData() -> String {
        var storesString = ""
        guard let gameStores = stores, gameStores.count != 0 else {
            return "Not available"
        }
        for store in gameStores {
            storesString += store.store.name
            if store.store.id != stores?.last?.store.id {
                storesString += ", "
            }
        }
        return storesString
    }
    
    func displayESRBData() -> String {
        esrbRating != nil ? esrbRating!.name : "Not available"
    }
            
    mutating func toggleIsInCollection() {
        isInCollection.toggle()
    }
    
    mutating func toggleIsOnWishlist() {
        isOnWishList.toggle()
    }
    
    func displayPublisherData() -> String {
        var publisherString = ""
        guard let gamePublishers = publishers, gamePublishers.count != 0 else {
            return "Not available"
        }
        for publisher in gamePublishers {
            publisherString += publisher.name
            if publisher.id != publishers?.last?.id {
                publisherString += ", "
            }
        }
        return publisherString
    }
    
    func displayDeveloperData() -> String {
        var developerString = ""
        guard let gameDevelopers = developers, gameDevelopers.count != 0 else {
            return "Not available"
        }
        for developer in gameDevelopers {
            developerString += developer.name
            if developer.id != developers?.last?.id {
                developerString += ", "
            }
        }
        return developerString
    }
    
} // End of struct
