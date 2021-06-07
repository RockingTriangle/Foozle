//
//  Genres.swift
//  Foozle
//
//  Created by Mike Conner on 6/7/21.
//

import Foundation

extension NetworkManager {
    
    enum Genres: String {
        case all = ""
        case action = "&genres=action"
        case indie = "&genres=indie"
        case adventure = "&genres=adventure"
        case rpg = "&genres=role-playing-games-rpg"
        case shooter = "&genres=shooter"
        case casual = "&genres=casual"
        case simulation = "&genres=simulation"
        case puzzle = "&genres=puzzle"
        case arcade = "&genres=arcade"
        case platformer = "&genres=platformer"
        case racing = "&genres=racing"
        case massMulty = "&genres=massively-multiplayer"
        case sports = "&genres=sports"
        case fighting = "&genres=fighting"
        case family = "&genres=family"
        case boardGames = "&genres=board-games"
        case eductional = "&genres=educational"
        case card = "&genres=card"
        
        var menuDescription: String {
            switch self {
            case .all:
                return "All Genres"
            case .action:
                return "Action"
            case .indie:
                return "Indie"
            case .adventure:
                return "Adventure"
            case .rpg:
                return "Role Playing Games"
            case .shooter:
                return "Shooter"
            case .casual:
                return "Casual"
            case .simulation:
                return "Simulation"
            case .puzzle:
                return "Puzzle"
            case .arcade:
                return "Arcade"
            case .platformer:
                return "Platformer"
            case .racing:
                return "Racing"
            case .massMulty:
                return "Massive Multiplayer"
            case .sports:
                return "Sports"
            case .fighting:
                return "Fighting"
            case .family:
                return "Family"
            case .boardGames:
                return "Board Games"
            case .eductional:
                return "Educational"
            case .card:
                return "Card"
            }
        }
        
        var titleDescription: String {
            switch self {
            case .all:
                return "All Genres"
            case .action:
                return "Action"
            case .indie:
                return "Indie"
            case .adventure:
                return "Adventure"
            case .rpg:
                return "RPG"
            case .shooter:
                return "Shooter"
            case .casual:
                return "Casual"
            case .simulation:
                return "Simulation"
            case .puzzle:
                return "Puzzle"
            case .arcade:
                return "Arcade"
            case .platformer:
                return "Platformer"
            case .racing:
                return "Racing"
            case .massMulty:
                return "Massive Multiplayer"
            case .sports:
                return "Sports"
            case .fighting:
                return "Fighting"
            case .family:
                return "Family"
            case .boardGames:
                return "Board Games"
            case .eductional:
                return "Educational"
            case .card:
                return "Cards"
            }
        }
    }
} // End of extension
