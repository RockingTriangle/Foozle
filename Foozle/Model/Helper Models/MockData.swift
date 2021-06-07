//
//  MockData.swift
//  Foozle
//
//  Created by Mike Conner on 5/27/21.
//

import SwiftUI

struct MockData {
    
    static let data = GameGeneralResponse(results: [GameResponse(id: 111, slug: "mock-data-game", name: "Mock Data Game", backgroundImage: "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noImage.png", released: "11/21/31", platforms: [Platforms(platform: Platform(id: 11, name: "XBOX"))], genres: [Genres(id: 11, name: "Horror")], stores: [Stores(store: Store(id: 6, name: "Starbucks"))], esrbRating: ESRBRating(id: 2, name: "kid friendly"))
    ])
    
    static let result = [data]
    
    static let game = GameResponse(id: 111, slug: "mock-data-game", name: "Mock Data Game", backgroundImage: "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noImage.png", released: "11/21/31", platforms: [Platforms(platform: Platform(id: 11, name: "XBOX"))], genres: [Genres(id: 11, name: "Horror")], stores: [Stores(store: Store(id: 6, name: "Starbucks"))], esrbRating: ESRBRating(id: 2, name: "kid friendly"))
    
} // End of struck
