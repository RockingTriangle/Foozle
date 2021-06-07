//
//  Platforms.swift
//  Foozle
//
//  Created by Mike Conner on 6/7/21.
//

import Foundation

extension NetworkManager {
    
    enum Platforms: String {
        case all = ""
        case computer = "&platforms=4,5,6,52,41"
        case playstation = "&platforms=5,18,16,15,27,19,17"
        case xbox = "&platforms=1,186,14,80"
        case nintendo = "&platforms=7,8,9,13,10,11,105,83,24,43,26,79,49"
        case mobile = "&platforms=3,21"
        
        var menuDescription: String {
            switch self {
            case .all:
                return "All Platforms"
            case .computer:
                return "Computer"
            case .playstation:
                return "Playstation"
            case .xbox:
                return "Xbox"
            case .nintendo:
                return "Nintendo"
            case .mobile:
                return "Mobile"
            }
        }
        
        var titleDescription: String {
            switch self {
            case .all:
                return "All Platforms"
            case .computer:
                return "Computer"
            case .playstation:
                return "PlayStation"
            case .xbox:
                return "Xbox"
            case .nintendo:
                return "Nintendo"
            case .mobile:
                return "Mobile"
            }
        }
    }    
} // End of extension
