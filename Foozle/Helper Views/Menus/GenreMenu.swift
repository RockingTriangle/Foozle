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
                    Button("All") { self.genre = .all }
                    Button("Action") { self.genre = .action }
                    Button("Indie") { self.genre = .indie }
                    Button("Adventure") { self.genre = .adventure }
                    Button("RPG") { self.genre = .rpg }
                    Button("Shooter") { self.genre = .shooter }
                    Button("Casual") { self.genre = .casual }
                    Button("Simulation") { self.genre = .simulation }
                    Button("Puzzle") { self.genre = .puzzle }
                    Button("Arcade") { self.genre = .arcade } } /// End of group...
                    Button("Platformer") { self.genre = .platformer }
                    Button("Racing") { self.genre = .racing }
                    Button("Massively Multiplayer") { self.genre = .massMulty }
                    Button("Sports") { self.genre = .sports }
                    Button("Fighting") { self.genre = .fighting }
                    Button("Family") { self.genre = .family }
                    Button("Board Games") { self.genre = .boardGames }
                    Button("Educational") { self.genre = .eductional }
                    Button("Card") { self.genre = .card }
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
