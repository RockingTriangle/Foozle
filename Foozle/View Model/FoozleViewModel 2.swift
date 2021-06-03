//
//  NewAndTrendingViewModel.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

final class FoozleViewModel: ObservableObject {
    
    @Published var gamesFromMainView: [GameGeneralResponse.GameResponse] = []
    @Published var gamesFromSearch: [GameGeneralResponse.GameResponse] = []

    @Published var selectedGame: GameGeneralResponse.GameResponse?
    @Published var additionalGameDetail: GameDetailResponse?
    @Published var selectedGameBackgroundImage: Image?
    @Published var isInCollection: Bool?
    @Published var isOnWishList: Bool?
    
    @Published var isLoading = false
    @Published var isShowingDetail = false
    
    @Published var foozleAlert: FoozleAlertItem?

    @Published var searchText: String = ""

    
    func getGamesForMainView() {
        isLoading = true
        NetworkManager.shared.getHighestRatedGames(endpoint: .games, sorting: .reverseAdded, searchTerm: nil) { [self] result in
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
        NetworkManager.shared.getHighestRatedGames(endpoint: .games, sorting: .reverseAdded, searchTerm: searchText) { [self] result in
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
        NetworkManager.shared.getGameData(endpoint: .games, id: selectedGame!.id) { [self] result in
            DispatchQueue.main.async {
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
    
} // End of class
