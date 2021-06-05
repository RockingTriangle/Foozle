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
    @State var startingDate = Date()
    @State var endingDate = Date()
    
    var body: some View {
        VStack {
            Text("Search Settings")
                .font(.largeTitle)
                .padding(.top, 16)
            Form {
                Section(header: Text("Sorting Method")) {
                    HStack {
                        Text(sorting.menuDescription)
                        Spacer()
                        SortingMenu(sorting: $sorting)
                    }
                }
                Section(header: Text("Platforms")) {
                    HStack {
                        Text(platform.menuDescription)
                        Spacer()
                        PlatformMenu(platforms: $platform)
                    }
                }
                Section(header: Text("Genres")) {
                    HStack {
                        Text(genre.menuDescription)
                        Spacer()
                        GenreMenu(genre: $genre)
                    }
                }
                Section(header: Text("Date Range")) {
                    DatePicker("Starting Date",
                               selection: self.$startingDate,
                               displayedComponents: .date)
                    DatePicker("Ending Date",
                               selection: self.$endingDate,
                               displayedComponents: .date)
                }
            }
        }
        .onChange(of: startingDate, perform: { value in
            if startingDate > endingDate {
                print("noooo")
            }
        })
        .onDisappear {
            viewModel.sortingSetting = sorting
            viewModel.platformSetting = platform
            viewModel.genreSetting = genre
            viewModel.gamesFromMainView = []
            convertDatesAndSaveToViewModel()
        }
        .overlay(FoozleDismissButton(viewModel: viewModel).padding(.trailing, 4), alignment: .topTrailing)
        .frame(width: UIScreen.screenWidth - 48, height: UIScreen.screenHeight * 0.80)
        .background(Color(.systemBackground))
        .cornerRadius(24)
        .shadow(radius: 40)
        
    }
    func convertDatesAndSaveToViewModel() {
        viewModel.startingDate = startingDate.formatToString()
        viewModel.endingDate = endingDate.formatToString()
    }
}
    struct SearchSettingView_Previews: PreviewProvider {
        static var previews: some View {
            SearchSettingView(viewModel: FoozleViewModel(), sorting: .none, platform: .all, genre: .all)
        }
    }
