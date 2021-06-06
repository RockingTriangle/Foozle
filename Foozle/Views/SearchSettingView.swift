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
                        SortingMenu(viewModel: viewModel, sorting: $sorting)
                    }
                }
                Section(header: Text("Platforms")) {
                    HStack {
                        Text(platform.menuDescription)
                        Spacer()
                        PlatformMenu(viewModel: viewModel, platforms: $platform)
                    }
                }
                Section(header: Text("Genres")) {
                    HStack {
                        Text(genre.menuDescription)
                        Spacer()
                        GenreMenu(viewModel: viewModel, genre: $genre)
                    }
                }
                Section(header: Text("Date Range")) {
                    DatePicker("Starting Date",
                               selection: $startingDate,
                               displayedComponents: .date)
                    DatePicker("Ending Date",
                               selection: $endingDate,
                               displayedComponents: .date)
                }
            }
        }
        .onAppear {
            
        }
        .onDisappear {
            viewModel.sortingSetting = sorting
            viewModel.platformSetting = platform
            viewModel.genreSetting = genre
            viewModel.gamesFromMainView = []
            viewModel.startingDate = startingDate
            viewModel.endingDate = endingDate
        }
        .overlay(DismissButton(viewModel: viewModel).padding(.trailing, 4), alignment: .topTrailing)
        .frame(width: UIScreen.screenWidth - 48, height: UIScreen.screenHeight * 0.80)
        .background(Color(.systemBackground))
        .cornerRadius(24)
        .shadow(radius: 40)
    }
    
    func getDateFromViewModel() {
        let startingDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startingDate)
        let endingDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endingDate)
        let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())

        if startingDateComponents != currentDateComponents && endingDateComponents != currentDateComponents {
            startingDate = viewModel.startingDate
            endingDate = viewModel.endingDate
        }
    }
    
}

struct SearchSettingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSettingView(viewModel: FoozleViewModel(), sorting: .none, platform: .all, genre: .all)
    }
}
