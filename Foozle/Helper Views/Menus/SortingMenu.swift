//
//  SortingMenu.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct SortingMenu: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    @Binding var sorting: NetworkManager.Sorting
    
    @State var frameHeight = 0
    @State var opacity = 0.0
    
    var body: some View {
        HStack {
            Spacer()
            Menu("Sorting") {
                Button("None") {
                    sorting = .none
                    viewModel.isShowingSortSettings = false
                }
                Menu("Name") {
                    Button("Ascending") {
                        sorting = .name
                        viewModel.isShowingSortSettings = false
                    }
                    Button("Descending") {
                        sorting = .reverseName
                        viewModel.isShowingSortSettings = false
                    }
                }
                Menu("Released") {
                    Button("Ascending") {
                        sorting = .released
                        viewModel.isShowingSortSettings = false
                    }
                    Button("Descending") {
                        sorting = .reverseReleased
                        viewModel.isShowingSortSettings = false
                    }
                }
                Menu("RAWG Rating") {
                    Button("Ascending") {
                        sorting = .rating
                        viewModel.isShowingSortSettings = false
                    }
                    Button("Descending") {
                        sorting = .reverseRating
                        viewModel.isShowingSortSettings = false
                        
                    }
                }
                Menu("Metacritic Rating") {
                    Button("Ascending") {
                        sorting = .metaRating
                        viewModel.isShowingSortSettings = false
                    }
                    Button("Descending") {
                        sorting = .reverseMetaRating
                        viewModel.isShowingSortSettings = false
                    }
                }
            }
            .menuStyle(MyMenuStyle())
        }
        .frame(width: 120)
        .frame(height: CGFloat(frameHeight))
        .opacity(opacity)
        .onAppear {
            withAnimation(.linear(duration: 0.3)) {
                frameHeight = 40
            }
            withAnimation(.easeIn(duration: 0.3).delay(0.3)) {
                opacity = 1
            }
            viewModel.isShowingCalendarSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
        }
    }
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(viewModel: FoozleViewModel(), sorting: .constant(.name))
    }
}
