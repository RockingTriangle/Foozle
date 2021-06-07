//
//  HomeView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var opacity: Double = 0
    
    var body: some View {
        VStack(alignment: .center) {
            Group {
                FoozleHeaderView()
                    .ignoresSafeArea()
                    .padding(.top, -50)
                SortAndFilterHeader(viewModel: viewModel)
                    .frame(height: 35)
                ZStack {
                    if viewModel.isShowingSortSettings {
                        SortingMenu(viewModel: viewModel, sorting: $viewModel.sortingSetting)
                    }
                    if viewModel.isShowingPlatformSettings {
                        PlatformMenu(viewModel: viewModel, platforms: $viewModel.platformSetting)
                    }
                    if viewModel.isShowingGenreSettings {
                        GenreMenu(viewModel: viewModel, genre: $viewModel.genreSetting)
                    }
                    if viewModel.isShowingCalendarSettings {
                        CalendarMenu(viewModel: viewModel, startingDate: $viewModel.startingDate, endingDate: $viewModel.endingDate, searchRange: $viewModel.searchRangeOfDates)
                    }
                }
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
            viewModel.isShowingSortSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
            viewModel.isShowingCalendarSettings = false
        }
        .alert(item: $viewModel.foozleAlert) { foozleAlertItem in
            Alert(title: foozleAlertItem.title, message: foozleAlertItem.message, dismissButton: foozleAlertItem.dismissButton)
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: FoozleViewModel())
    }
}
