//
//  MockData.swift
//  Foozle
//
//  Created by Mike Conner on 5/27/21.
//

import SwiftUI

struct MockData {
    
    static let data = GameGeneralResponse(results: [GameGeneralResponse.GameResponse(id: 111, name: "Mock Data Game", backgroundImage: "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noResults.png", released: "11/21/31", platforms: [GameGeneralResponse.GameResponse.Platforms(platform: GameGeneralResponse.GameResponse.Platforms.Platform(id: 11, name: "XBOX"))], genres: [GameGeneralResponse.GameResponse.Genres(id: 11, name: "Horror")], stores: [GameGeneralResponse.GameResponse.Stores(store: GameGeneralResponse.GameResponse.Stores.Store(id: 6, name: "Starbucks"))], esrbRating: GameGeneralResponse.GameResponse.ESRBRating(id: 2, name: "kid friendly"))
    ])
    
    static let result = [data]
    
    static let game = GameGeneralResponse.GameResponse(id: 111, name: "Mock Data Game", backgroundImage: "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noResults.png", released: "11/21/31", platforms: [GameGeneralResponse.GameResponse.Platforms(platform: GameGeneralResponse.GameResponse.Platforms.Platform(id: 11, name: "XBOX"))], genres: [GameGeneralResponse.GameResponse.Genres(id: 11, name: "Horror")], stores: [GameGeneralResponse.GameResponse.Stores(store: GameGeneralResponse.GameResponse.Stores.Store(id: 6, name: "Starbucks"))], esrbRating: GameGeneralResponse.GameResponse.ESRBRating(id: 2, name: "kid friendly"))
    
} // End of struck
