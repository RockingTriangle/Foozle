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
            print("There was an error creating the URL.")
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
                print("Invalid response from server: \(response?.description ?? "No Response")")
                return
            }
            guard let data = data else {
                completed(.failure(.invalidResponse))
                print("No data returned from server.")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(GameGeneralResponse.self, from: data)
                decodedResponse.results.isEmpty ? completed(.failure(.noResultsFromServer)) : completed(.success(decodedResponse.results))
            } catch {
                completed(.failure(.invalidData))
                print("We were unable to decode the data that was recieved fro the server.")
            }
        }.resume()
    }
    
    func getGameDetails(endpoint: Endpoint, id: Int, completed: @escaping (Result<GameDetailResponse, FoozleError>) -> Void) {
        
        let urlString = baseURL + endpoint.rawValue + "/\(id)" + apiKey  
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            print("There was an error creating the URL.")
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
                print("Invalid response from server: \(response?.description ?? "No Response")")
                return
            }
            guard let data = data else {
                completed(.failure(.invalidResponse))
                print("No data returned from server.")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(GameDetailResponse.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
                print("We were unable to decode the data that was recieved fro the server.")
            }
        }.resume()
    }
    
    func getGameDetailsForCollectionView(endpoint: Endpoint, slug: String, completed: @escaping (Result<CollectionViewGameData, FoozleError>) -> Void) {
                
        let urlString = baseURL + endpoint.rawValue + "/" + slug + apiKey
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            print("There was an error creating the URL.")
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
                print("Invalid response from server: \(response?.description ?? "No Response")")
                return
            }
            guard let data = data else {
                completed(.failure(.invalidResponse))
                print("No data returned from server.")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(CollectionViewGameData.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
                print("We were unable to decode the data that was recieved fro the server.")
            }
        }.resume()
    }
    
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
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error  = error {
                completion(nil)
                print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
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

