//
//  NewAndTrendingViewModel.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

final class FoozleViewModel: ObservableObject {
    
    @Published var gamesFromMainView: [GameResponse] = []
    @Published var gamesFromSearch: [GameResponse] = []

    @Published var selectedGame: GameResponse?
    @Published var additionalGameDetail: GameDetailResponse?
    @Published var selectedGameBackgroundImage: Image?
    @Published var isInCollection: Bool?
    @Published var isOnWishList: Bool?
    
    @Published var collectionViewSlugName = ""
    
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var isShowingCollectionDetail = false
    @Published var isShowingSortSettings = false
    @Published var isShowingPlatformSettings = false
    @Published var isShowingGenreSettings = false
    @Published var isShowingCalendarSettings = false
    @Published var isShowingSettings = false
    
    @Published var sortingSetting: NetworkManager.Sorting = .reverseMetaRating
    @Published var platformSetting: NetworkManager.Platforms = .all
    @Published var genreSetting: NetworkManager.Genres = .all
    
    @Published var startingDate: Date = Date().addingTimeInterval(Date().timeIntervalSinceNow - Date().timeIntervalSince1970) {
        didSet {
            if startingDate == Date() || startingDate >= endingDate {
                startingDate = endingDate.addingTimeInterval(-86400)
            }
        }
    }
    @Published var endingDate: Date = Date() {
        didSet {
            if startingDate >= endingDate {
                endingDate = startingDate.addingTimeInterval(86400)
            }
        }
    }
    @Published var searchRangeOfDates = false
    
    @Published var foozleAlert: AlertItem?

    @Published var searchText: String = ""
    
    @Published var refresh: Bool = true
    
    func getDateRange() -> String {
        let startingDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startingDate)
        let endingDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endingDate)
        if startingDateComponents == endingDateComponents || !searchRangeOfDates {
            return ""
        }
        return "&dates=\(startingDate.formatToSearch()),\(endingDate.formatToSearch())"
    }
    
    func getGamesForMainView() {
        isLoading = true
        NetworkManager.shared.getGames(endpoint: .games, sorting: sortingSetting, genre: genreSetting, platform: platformSetting, searchTerm: nil, dateRange: getDateRange()) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let games):
                    self.gamesFromMainView = games
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = AlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = AlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = AlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = AlertContext.unableToComplete
                    case .noResultsFromServer:
                        foozleAlert = AlertContext.noResultsFromSearch
                    case .errorLoadingPersistentStore:
                        foozleAlert = AlertContext.errorLoadingPersistentStore
                    case .unableToSaveContext:
                        foozleAlert = AlertContext.unableToSaveContext
                    }
                }
            }
        }
    }
    
    func getGamesForSearchView() {
        isLoading = true
        NetworkManager.shared.getGames(endpoint: .games, sorting: sortingSetting, genre: genreSetting, platform: platformSetting, searchTerm: searchText, dateRange: getDateRange()) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let games):
                    self.gamesFromSearch = []
                    self.gamesFromSearch = games
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = AlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = AlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = AlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = AlertContext.unableToComplete
                    case .noResultsFromServer:
                        foozleAlert = AlertContext.noResultsFromSearch
                    case .errorLoadingPersistentStore:
                        foozleAlert = AlertContext.errorLoadingPersistentStore
                    case .unableToSaveContext:
                        foozleAlert = AlertContext.unableToSaveContext
                    }
                }
            }
        }
    }
    
    func getAdditionalGameDetails() {
        isLoading = true
        NetworkManager.shared.getGameDetails(endpoint: .games, id: selectedGame!.id) { [self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
                switch result {
                case .success(let gameDetail):
                    additionalGameDetail = gameDetail
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = AlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = AlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = AlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = AlertContext.unableToComplete
                    case .noResultsFromServer:
                        foozleAlert = AlertContext.noResultsFromSearch
                    case .errorLoadingPersistentStore:
                        foozleAlert = AlertContext.errorLoadingPersistentStore
                    case .unableToSaveContext:
                        foozleAlert = AlertContext.unableToSaveContext
                    }
                }
            }
        }
    }
    
    func getCollectionViewGameDetails(collection: Bool, wishList: Bool) {
        isLoading = true
        NetworkManager.shared.getGameDetailsForCollectionView(endpoint: .games, slug: collectionViewSlugName) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let gameDetail):
                    convertGameData(game: gameDetail, collection: collection, wishList: wishList)
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = AlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = AlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = AlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = AlertContext.unableToComplete
                    case .noResultsFromServer:
                        foozleAlert = AlertContext.noResultsFromSearch
                    case .errorLoadingPersistentStore:
                        foozleAlert = AlertContext.errorLoadingPersistentStore
                    case .unableToSaveContext:
                        foozleAlert = AlertContext.unableToSaveContext
                    }
                }
            }
        }
    }
    
    func convertGameData(game: CollectionViewGameData, collection: Bool, wishList: Bool) {
        let collectionGame = GameResponse(id: game.id, slug: game.slug, name: game.name, backgroundImage: game.backgroundImage, released: game.released, platforms: game.platforms, genres: game.genres, stores: game.stores, esrbRating: game.esrbRating, isInCollection: collection, isOnWishList: wishList)
        
        selectedGame = collectionGame
        isInCollection = collection
        isOnWishList = wishList
        isShowingCollectionDetail = true
    }
    
} // End of class
