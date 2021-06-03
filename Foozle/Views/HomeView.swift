//
//  NewAndTrendingView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: CollectionGame.entity(), sortDescriptors: [])
    var gameCollection: FetchedResults<CollectionGame>
    
    @FetchRequest(entity: WishListGame.entity(), sortDescriptors: [])
    var gameWishList: FetchedResults<WishListGame>
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Group {
                FoozleHeaderView()
                    .ignoresSafeArea()
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
                    .navigationTitle(Text("New and Trending"))
                    .disabled(viewModel.isShowingDetail)
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
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
