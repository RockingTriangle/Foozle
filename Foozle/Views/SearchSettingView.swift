//
//  SearchSettingView.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct SearchSettingView: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    @State var sorting: NetworkManager.Sorting
    @State var platform: NetworkManager.Platforms
    @State var genre: NetworkManager.Genres
    
    var body: some View {
        VStack {
            Text("Search Settings")
                .font(.largeTitle)
                .padding(.top, 16)
            Form {
                Section(header: Text("Sorting Method")) {
                    HStack {
                        Text(sorting.foozleDescription)
                        Spacer()
                        SortingMenu(sorting: $sorting)
                    }
                }
                Section(header: Text("Platforms")) {
                    HStack {
                        Text(platform.foozleDescription)
                        Spacer()
                        PlatformMenu(platforms: $platform)
                    }
                }
                Section(header: Text("Genres")) {
                    HStack {
                        Text(genre.foozleDescription)
                        Spacer()
                        GenreMenu(genre: $genre)
                    }
                }
            }
            .onDisappear {
                viewModel.sortingSetting = sorting
                viewModel.platformSetting = platform
                viewModel.genreSetting = genre
            }
        }
        .overlay(Button {
            viewModel.isShowingSettings = false
        } label: {
            FoozleDismissButton().padding(.trailing, 4)
        }, alignment: .topTrailing)
        .frame(width: UIScreen.screenWidth - 48, height: UIScreen.screenHeight * 0.80)
        .background(Color(.systemBackground))
        .cornerRadius(24)
        .shadow(radius: 40)
    }
}

struct SearchSettingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSettingView(viewModel: FoozleViewModel(), sorting: .none, platform: .all, genre: .all)
    }
}
