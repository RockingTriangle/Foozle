//
//  FoozleTabView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct FoozleTabView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.scenePhase) var scenePhase
    @StateObject var viewModel = FoozleViewModel()
    @State var tabIndex: Int
    
    var body: some View {
        if viewModel.isShowingSettings {
            SearchSettingView(viewModel: viewModel, sorting: viewModel.sortingSetting, platform: viewModel.platformSetting, genre: viewModel.genreSetting)
        } else {
            TabView(selection: $tabIndex) {
                HomeView(viewModel: viewModel, navigationTitle: "")
                    .tabItem {
                        Image(systemName: "newspaper")
                        Text("Trending")
                            
                    }
                    .tag(1)
                SearchView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "binoculars")
                        Text("Search")
                           
                    }
                    .tag(2)
                CollectionView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "books.vertical")
                        Text("Collection")
                            
                    }
                    .tag(3)
            }
            .accentColor(.primary)
        }
    }
}

struct FoozleTabView_Previews: PreviewProvider {
    static var previews: some View {
        FoozleTabView(tabIndex: .zero)
    }
}
