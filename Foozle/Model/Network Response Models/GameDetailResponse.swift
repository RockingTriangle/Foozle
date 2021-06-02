//
//  GameDetailResponse.swift
//  Foozle
//
//  Created by Mike Conner on 5/27/21.
//

import SwiftUI

struct GameDetailResponse: Codable {
    let publishers: [Publisher]?
    let developers: [Developer]?
    let descriptionRaw: String
    let website: String
    
    struct Publisher: Codable {
        let id: Int
        let name: String
    }
    
    struct Developer: Codable {
        let id: Int
        let name: String
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

}// End of class
