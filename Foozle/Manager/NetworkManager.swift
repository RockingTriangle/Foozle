//
//  NetworkManager.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import UIKit

final class NetworkManager {
    
    private let apiKey = "?key=7351a7a1567a487b9815ed91c436349f"
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    let baseURL = "https://api.rawg.io/api/"
    
    // MARK: - Functions
    func getHighestRatedGames(endpoint: Endpoint, sorting: Sorting, searchTerm: String?, completed: @escaping (Result<[GameGeneralResponse.GameResponse], FoozleError>) -> Void) {
        
        var searchTerm = searchTerm ?? ""
        searchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        searchTerm = searchTerm.count == 0 ? "" : "&search=" + searchTerm
        var preciseSearch: String {
            searchTerm == "" ? "" : "&search_exact=true"
        }
        
        let urlString = baseURL + endpoint.rawValue + apiKey + searchTerm + sorting.rawValue + preciseSearch
        
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
                let decodedResponse = try decoder.decode(GameGeneralResponse.self, from: data)
                completed(.success(decodedResponse.results))
                print("decoded")
            } catch {
                completed(.failure(.invalidData))
                print("could not decode")
            }
            
        }.resume()
        
    } // end getHighestRatedGames
    
    func getGameData(endpoint: Endpoint, id: Int, completed: @escaping (Result<GameDetailResponse, FoozleError>) -> Void) {
        
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
    
    func getGameDataForCollectionView(endpoint: Endpoint, name: String, completed: @escaping (Result<CollectionViewGameData, FoozleError>) -> Void) {
        
        var slug = name
        slug = slug.replacingOccurrences(of: " ", with: "-").lowercased()
        slug = slug.replacingOccurrences(of: ":", with: "")
        
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
        case developers = "developers"
        case genres = "genres"
        case platforms = "platforms"
        case publishers = "publishers"
        case stores = "stores"
    }
    
    enum Sorting: String {
        case name = "&ordering=name"
        case reverseName = "&ordering=-name"
        case released = "&ordering=released"
        case reverseReleased = "&ordering=-released"
        case added = "&ordering=added"
        case reverseAdded = "&ordering=-added"
        case rating = "&ordering=rating"
        case reverseRating = "&ordering=-rating"
        
    }
    
} // End of extension
