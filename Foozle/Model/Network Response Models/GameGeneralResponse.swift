//
//  GameGeneralResponse.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct GameGeneralResponse: Codable {
    
    let results: [GameResponse]
    
} // End of struct


struct GameResponse: Codable, Identifiable {
    let id: Int
    let slug: String
    let name: String
    let backgroundImage: String?
    let released: String?
    let platforms: [Platforms]
    let genres: [Genres]?
    let stores: [Stores]?
    let esrbRating: ESRBRating?
    
    lazy var isInCollection: Bool = false
    lazy var isOnWishList: Bool = false
    
    
    // MARK: - Functions
    func displayBackgroundImage() -> String {
        backgroundImage != nil ? backgroundImage! : "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noResults.png"
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
    
} // End of struct

struct Platforms: Codable {
    let platform: Platform
} // End of struct

struct Platform: Codable, Identifiable {
    let id: Int
    let name: String
}

struct Genres: Codable, Identifiable {
    let id: Int
    let name: String
} // End of struct

struct Stores: Codable {
    let store: Store
} // End of struct

struct Store: Codable, Identifiable {
    let id: Int
    let name: String
}

struct ESRBRating: Codable, Identifiable {
    let id: Int
    let name: String
} // End of struct
