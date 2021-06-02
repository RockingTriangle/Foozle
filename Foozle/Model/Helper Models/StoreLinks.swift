//
//  StoreLinks.swift
//  Foozle
//
//  Created by Mike Conner on 5/30/21.
//

import SwiftUI

struct StoreLinks {

    static let steam        = Link(destination: URL(string: "https://store.steampowered.com")!)     { Image("steam").resizable() }
    static let playstation  = Link(destination: URL(string: "https://store.playstation.com")!)      { Image("playstation").resizable() }
    static let xBox         = Link(destination: URL(string: "https://microsoft.com")!)              { Image("xbox").resizable() }
    static let appStore     = Link(destination: URL(string: "https://www.apple.com/app-store")!)    { Image("appStore").resizable() }
    static let gog          = Link(destination: URL(string: "https://www.gog.com")!)                { Image("gog").resizable() }
    static let nintendo     = Link(destination: URL(string: "https://www.nintendo.com")!)           { Image("nintendo").resizable() }
    static let xbox360      = Link(destination: URL(string: "https://marketplace.xbox.com")!)       { Image("xbox360").resizable() }
    static let googlePlay   = Link(destination: URL(string: "https://play.google.com")!)            { Image("googlePlay").resizable() }
    static let itchIO       = Link(destination: URL(string: "https://itch.io")!)                    { Image("itchio").resizable() }
    static let epicGames    = Link(destination: URL(string: "https://epicgames.com")!)              { Image("epicGames").resizable() }

    
    static func displayStoreLinks(_ stores: [GameGeneralResponse.GameResponse.Stores]?) -> [Link<Image>] {
        
        var storesArray = [Link<Image>]()
        if let stores = stores {
            for store in stores {                
                switch store.store.name.lowercased() {
                case "steam":
                    storesArray.append(steam)
                case "playstation store":
                    storesArray.append(playstation)
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
