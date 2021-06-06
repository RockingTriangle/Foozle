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
                    .overlay(Button {
                        viewModel.isShowingSettings = true
                    } label: {
                        SettingsButton().padding(.trailing, 10)
                    }, alignment: .topTrailing)
                SortAndFilterHeader(viewModel: viewModel)
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
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: FoozleViewModel())
    }
}
