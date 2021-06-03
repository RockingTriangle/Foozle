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
                if !viewModel.isShowingDetail {
                    SearchBarView(text: $searchText, viewModel: viewModel)
                }                
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
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            if viewModel.isShowingDetail {
                GameDetailView(game: viewModel.selectedGame!, viewModel: viewModel, isShowingDetail: $viewModel.isShowingDetail)
            }
        }
        .alert(item: $viewModel.foozleAlert) { foozleAlertItem in
            Alert(title: foozleAlertItem.title, message: foozleAlertItem.message, dismissButton: foozleAlertItem.dismissButton)
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
