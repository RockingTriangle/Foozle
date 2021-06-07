//
//  Sorting.swift
//  Foozle
//
//  Created by Mike Conner on 6/7/21.
//

import Foundation

extension NetworkManager {
    
    enum Sorting: String {
        case none = ""
        case name = "&ordering=name"
        case reverseName = "&ordering=-name"
        case released = "&ordering=released"
        case reverseReleased = "&ordering=-released"
        case rating = "&ordering=rating"
        case reverseRating = "&ordering=-rating"
        case metaRating = "&ordering=metacritic"
        case reverseMetaRating = "&ordering=-metacritic"
        
        var menuDescription: String {
            switch self {
            case .none:
                return "No sorting"
            case .name:
                return "Name - Ascending"
            case .reverseName:
                return "Name - Descending"
            case .released:
                return "Released - Ascending"
            case .reverseReleased:
                return "Released - Descending"
            case .rating:
                return "Rating - Ascending"
            case .reverseRating:
                return "Rating - Descending"
            case .metaRating:
                return "Metacritic - Ascending"
            case .reverseMetaRating:
                return "Metacritic - Descending"
            }
        }
        
        var titleDescription: String {
            switch self {
            case .none:
                return "None"
            case .name:
                return "Name: "
            case .reverseName:
                return "Name: "
            case .released:
                return "Released: "
            case .reverseReleased:
                return "Released: "
            case .rating:
                return "Rating: "
            case .reverseRating:
                return "Rating: "
            case .metaRating:
                return "Metacritic: "
            case .reverseMetaRating:
                return "Metacritic: "
            }
        }
    }
} // End of extension
    
