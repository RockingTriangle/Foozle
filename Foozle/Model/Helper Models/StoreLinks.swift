//
//  StoreLinks.swift
//  Foozle
//
//  Created by Mike Conner on 5/30/21.
//

import SwiftUI

struct StoreLinks {

    static let steam       = Link("Steam",             destination: URL(string: "https://store.steampowered.com")!)
    static let playStation = Link("PlayStation", destination: URL(string: "https://store.playstation.com")!)
    static let xBox        = Link("Xbox",        destination: URL(string: "https://www.microsoft.com")!)
    static let appStore    = Link("App Store",         destination: URL(string: "https://www.apple.com/app-store")!)
    static let gog         = Link("GOG",               destination: URL(string: "https://www.gog.com")!)
    static let nintendo    = Link("Nintendo",    destination: URL(string: "https://www.nintendo.com")!)
    static let xbox360     = Link("Xbox 360",          destination: URL(string: "https://marketplace.xbox.com")!)
    static let googlePlay  = Link("Google Play",       destination: URL(string: "https://play.google.com")!)
    static let itchIO      = Link("itch.io",           destination: URL(string: "https://itch.io")!)
    static let epicGames   = Link("Epic Games",        destination: URL(string: "https://epicgames.com")!)
    
    
    static func displayStoreLinks(_ stores: [GameGeneralResponse.GameResponse.Stores]?) -> [Link<Text>] {
        
        var storesArray = [Link<Text>]()
        
        if let stores = stores {
        
            for store in stores {
                
                switch store.store.name.lowercased() {
                case "steam":
                    storesArray.append(steam)
                case "playstation store":
                    storesArray.append(playStation)
                case "xbox store":
                    storesArray.append(xBox)
                case "app store":
                    storesArray.append(appStore)
                case "gog":
                    storesArray.append(gog)
                case "nintendo store":
                    storesArray.append(nintendo)
                case "xbox 360 store":
                    storesArray.append(xbox360)
                case "google play":
                    storesArray.append(googlePlay)
                case "itch.io":
                    storesArray.append(itchIO)
                case "epic games":
                    storesArray.append(epicGames)
                default:
                    break
                }
            }
        } else {
            storesArray = []
        }
        
        return storesArray
    }
    
} // End of struct
