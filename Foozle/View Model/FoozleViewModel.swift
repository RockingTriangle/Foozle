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
    @Published var isShowingSettings = false
    
    @Published var sortingSetting: NetworkManager.Sorting = .none
    @Published var platformSetting: NetworkManager.Platforms = .all
    @Published var genreSetting: NetworkManager.Genres = .all
    
    @Published var foozleAlert: FoozleAlertItem?

    @Published var searchText: String = ""
    
    @Published var refresh: Bool = true

    
    func getGamesForMainView() {
        isLoading = true
        NetworkManager.shared.getGames(endpoint: .games, sorting: sortingSetting, genre: genreSetting, platform: platformSetting, searchTerm: nil) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let games):
                    self.gamesFromMainView = games
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = FoozleAlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = FoozleAlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = FoozleAlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = FoozleAlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getGamesFromSearch() {
        isLoading = true
        NetworkManager.shared.getGames(endpoint: .games, sorting: sortingSetting, genre: genreSetting, platform: platformSetting, searchTerm: searchText) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let games):
                    self.gamesFromSearch = []
                    self.gamesFromSearch = games
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = FoozleAlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = FoozleAlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = FoozleAlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = FoozleAlertContext.unableToComplete
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
                        foozleAlert = FoozleAlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = FoozleAlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = FoozleAlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = FoozleAlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getCollectionViewGameDetails(collection: Bool, wishList: Bool) {
        isLoading = true
        NetworkManager.shared.getGameDataForCollectionView(endpoint: .games, slug: collectionViewSlugName) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let gameDetail):
                    convertGameData(game: gameDetail, collection: collection, wishList: wishList)
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        foozleAlert = FoozleAlertContext.invalidData
                    case .invalidResponse:
                        foozleAlert = FoozleAlertContext.invalidResponse
                    case .invalidURL:
                        foozleAlert = FoozleAlertContext.invalidURL
                    case .unableToComplete:
                        foozleAlert = FoozleAlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func convertGameData(game: CollectionViewGameData, collection: Bool, wishList: Bool) {
        let collectionGame = GameResponse(id: 99, slug: game.slug, name: game.name, backgroundImage: game.backgroundImage, released: game.released, platforms: game.platforms, genres: game.genres, stores: game.stores, esrbRating: game.esrbRating, isInCollection: collection, isOnWishList: wishList)
        
        selectedGame = collectionGame
        isInCollection = collection
        isOnWishList = wishList
        isShowingCollectionDetail = true
    }
    
} // End of class
