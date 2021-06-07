//
//  RefreshButton.swift
//  Foozle
//
//  Created by Mike Conner on 6/5/21.
//

import SwiftUI

struct RefreshButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: "arrow.clockwise")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(.black)
        }
        .onTapGesture {
            viewModel.gamesFromMainView = []
            viewModel.getGamesForMainView()
            if viewModel.gamesFromSearch.count != 0 {
                viewModel.gamesFromSearch = []
                viewModel.getGamesForSearchView()
            }
            viewModel.isShowingSortSettings = false
            viewModel.isShowingCalendarSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
        }
    }
}
