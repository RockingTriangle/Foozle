//
//  HomeView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
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
                    .disabled(viewModel.isShowingSettings)
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
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(Text("Featured Games"))
                    .disabled(viewModel.isShowingDetail)
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            .blur(radius: viewModel.isShowingSettings ? 20 : 0)
            if viewModel.isShowingDetail {
                GameDetailView(game: viewModel.selectedGame!, viewModel: viewModel, isShowingDetail: $viewModel.isShowingDetail)
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

struct NewAndTrendingView_Previews: PreviewProvider {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    static var previews: some View {
        HomeView(viewModel: FoozleViewModel())
    }
}
