//
//  HomeView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct HomeView: View {
    
    init(viewModel: FoozleViewModel, navigationTitle: String) {
        let appearance = UINavigationBarAppearance()

        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor(.primary)
        ]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        UINavigationBar.appearance().tintColor = UIColor(.primary)
        
        self.viewModel = viewModel
        self.navigationTitle = navigationTitle
        
    }
    
    @ObservedObject var viewModel: FoozleViewModel
    var navigationTitle: String
    
    var body: some View {        
        
        VStack(alignment: .center) {
            Group {
                FoozleHeaderView()
                    .ignoresSafeArea()
                    .overlay(Button {
                        viewModel.isShowingSettings = true
                    } label: {
                        FoozleSettingsButton().padding(.trailing, 10)
                    }, alignment: .topTrailing)
                
                SortAndFilterHeader(viewModel: viewModel)
                Divider()
                    .padding(0)
                
                NavigationView {
                    List() {
                        ForEach(viewModel.gamesFromMainView) { game in
                            FoozleRowCell(game: game)
                                .listRowInsets(EdgeInsets(top: 8, leading: UIScreen.screenWidth * 0.05, bottom: 8, trailing: UIScreen.screenWidth * 0.05))
                                .onTapGesture {
                                    viewModel.selectedGame = game
                                    viewModel.isShowingDetail = true
                                    viewModel.isInCollection = viewModel.selectedGame!.isInCollection
                                    viewModel.isOnWishList = viewModel.selectedGame!.isOnWishList
                                }
                        }
                    }
                    .navigationBarHidden(true)
                    .disabled(viewModel.isShowingDetail)
                    .disabled(viewModel.isShowingSettings)
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            .blur(radius: viewModel.isShowingSettings ? 20 : 0)
            if viewModel.isShowingDetail {
                GameDetailView(game: viewModel.selectedGame!, viewModel: viewModel, isShowingDetail: $viewModel.isShowingDetail)
            } else if viewModel.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            viewModel.gamesFromMainView.count == 0 ? viewModel.getGamesForMainView() : nil
        }
        .onDisappear {
            viewModel.isShowingDetail = false
        }
        .alert(item: $viewModel.foozleAlert) { foozleAlertItem in
            Alert(title: foozleAlertItem.title, message: foozleAlertItem.message, dismissButton: foozleAlertItem.dismissButton)
        }
    }
}

