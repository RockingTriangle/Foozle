//
//  GenreButton.swift
//  Foozle
//
//  Created by Mike Conner on 6/5/21.
//

import SwiftUI

struct GenreButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isShowingGenreSettings ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: "puzzlepiece")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isShowingGenreSettings ? .white :.black)
        }
        .onTapGesture {
            if viewModel.isShowingGenreSettings {
                viewModel.isShowingGenreSettings = false
            } else {
                viewModel.isShowingGenreSettings = true
            }
        }
    }
}
