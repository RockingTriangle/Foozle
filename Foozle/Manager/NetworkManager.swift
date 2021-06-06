//
//  NetworkManager.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

final class NetworkManager {
    
    private let apiKey = "?key=7351a7a1567a487b9815ed91c436349f"
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    let baseURL = "https://api.rawg.io/api/"
    
    // MARK: - Functions
    func getGames(endpoint: Endpoint, sorting: Sorting, genre: Genres, platform: Platforms, searchTerm: String?, dateRange: String, completed: @escaping (Result<[GameResponse], FoozleError>) -> Void) {
        
        var searchTerm = searchTerm ?? ""
        searchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        searchTerm = searchTerm.count == 0 ? "" : "&search=" + searchTerm
        var preciseSearch: String {
            searchTerm == "" ? "" : "&search_exact=true"
        }
        
        let urlString = baseURL + endpoint.rawValue + apiKey + searchTerm + dateRange + sorting.rawValue + genre.rawValue + platform.rawValue + preciseSearch
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completed(.failure(.unableToComplete))
                print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidResponse))
                print("no data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(GameGeneralResponse.self, from: data)
                completed(.success(decodedResponse.results))
                print("decoded")
            } catch {
                completed(.failure(.invalidData))
                print("could not decode")
            }
            
        }.resume()
        
    } // end getGames function
    
    func getGameDetails(endpoint: Endpoint, id: Int, completed: @escaping (Result<GameDetailResponse, FoozleError>) -> Void) {
        
        let urlString = baseURL + endpoint.rawValue + "/\(id)" + apiKey  
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            print("failed url")
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // TODO: - fix error to add to message
            if let _ = error {
                completed(.failure(.unableToComplete))
                print("error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                print("no/wrong response")
                return
            }
            guard let data = data else {
                completed(.failure(.invalidResponse))
                print("no data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(GameDetailResponse.self, from: data)
                completed(.success(decodedResponse))
                print("decoded")
            } catch {
                completed(.failure(.invalidData))
                print("could not decode")
            }
            
        }.resume()
        
    } // end getGameData
    
    func getGameDataForCollectionView(endpoint: Endpoint, slug: String, completed: @escaping (Result<CollectionViewGameData, FoozleError>) -> Void) {
                
        let urlString = baseURL + endpoint.rawValue + "/" + slug + apiKey
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            print("failed url")
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // TODO: - fix error to add to message
            if let _ = error {
                completed(.failure(.unableToComplete))
                print("error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                print("no/wrong response")
                return
            }
            guard let data = data else {
                completed(.failure(.invalidResponse))
                print("no data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(CollectionViewGameData.self, from: data)
                completed(.success(decodedResponse))
                print("decoded")
            } catch {
                completed(.failure(.invalidData))
                print("could not decode")
            }
            
        }.resume()
        
    } // end getHighestRatedGames
    
    func downloadImage(fromUrlString urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // TODO: - fix error to add to message
            if let _  = error {
                completion(nil)
                print("image error")
                return
            }
            guard let _ = response as? HTTPURLResponse else {
                completion(nil)
                print("image response")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                print("image data")
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
        
    } // end downloadImage
    
} // End of class

extension NetworkManager {
    
    enum Endpoint: String {
        case games = "games"
        case genres = "genres"
        case platforms = "platforms"
    }
    
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

