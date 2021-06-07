//
//  SearchView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    @State private var searchText = ""

    var body: some View {
        VStack {
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
                Spacer()
                    .frame(height: 10)
                if !viewModel.isShowingDetail {
                    SearchBarView(text: $searchText, viewModel: viewModel)
                }
                Spacer().frame(height: 10)
                NavigationView {
                    List(viewModel.gamesFromSearch) { game in
                        FoozleRowCell(game: game)
                            .onTapGesture {
                                viewModel.selectedGame = game
                                viewModel.isShowingDetail = true
                            }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                    .disabled(viewModel.isShowingDetail)
                    .disabled(viewModel.isShowingSettings)
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            if viewModel.isShowingDetail {
                GameDetailView(game: viewModel.selectedGame!, viewModel: viewModel, isShowingDetail: $viewModel.isShowingDetail)
            } else if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.foozleAlert) { foozleAlertItem in
            Alert(title: foozleAlertItem.title, message: foozleAlertItem.message, dismissButton: foozleAlertItem.dismissButton)
        }
        .onAppear {
            if viewModel.searchText != "" {
                searchText = viewModel.searchText
            }
        }
        .onDisappear {
            viewModel.isShowingDetail = false
            viewModel.isShowingSortSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
            viewModel.isShowingCalendarSettings = false
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: FoozleViewModel())
    }
}
