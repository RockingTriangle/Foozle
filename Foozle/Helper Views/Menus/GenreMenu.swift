//
//  GenreMenu.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct GenreMenu: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    @Binding var genre: NetworkManager.Genres
    
    @State var frameHeight = 0
    @State var opacity = 0.0
    
    var body: some View {
        HStack {
            Spacer()
            Menu("Genres") {
                Group {
                    Button("All") {
                        self.genre = .all
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Action") {
                        self.genre = .action
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Indie") {
                        self.genre = .indie
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Adventure") {
                        self.genre = .adventure
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("RPG") {
                        self.genre = .rpg
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Shooter") {
                        self.genre = .shooter
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Casual") {
                        self.genre = .casual
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Simulation") {
                        self.genre = .simulation
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Puzzle") {
                        self.genre = .puzzle
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Arcade") {
                        self.genre = .arcade
                        viewModel.isShowingGenreSettings = false
                    }
                    
                } /// End of group...
                    Button("Platformer") {
                        self.genre = .platformer
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Racing") {
                        self.genre = .racing
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Massively Multiplayer") {
                        self.genre = .massMulty
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Sports") {
                        self.genre = .sports
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Fighting") {
                        self.genre = .fighting
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Family") {
                        self.genre = .family
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Board Games") {
                        self.genre = .boardGames
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Educational") {
                        self.genre = .eductional
                        viewModel.isShowingGenreSettings = false
                    }
                    Button("Card") {
                        self.genre = .card
                        viewModel.isShowingGenreSettings = false
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
            viewModel.isShowingSortSettings = false
            viewModel.isShowingPlatformSettings = false
        }
    }
}

struct GenreMenu_Previews: PreviewProvider {
    static var previews: some View {
        GenreMenu(viewModel: FoozleViewModel(), genre: .constant(.all))
    }
}
