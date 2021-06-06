//
//  CollectionButton.swift
//  Foozle
//
//  Created by Mike Conner on 5/30/21.
//

import SwiftUI

struct CollectionButton: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: CollectionGame.entity(), sortDescriptors: [])
    var gameCollection: FetchedResults<CollectionGame>
        
    @State var game: GameResponse
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isInCollection ?? false ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: viewModel.isInCollection ?? false ? "books.vertical.fill" : "books.vertical")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isInCollection ?? false ? .white : .black)
        }
        .onAppear{
            for selectedGame in gameCollection {
                if selectedGame.name == game.name {
                    game.isInCollection = true
                    viewModel.isInCollection = true
                    break
                } else {
                    game.isInCollection = false
                    viewModel.isInCollection = false
                }
            }
        }
        .onTapGesture {
            viewModel.refresh.toggle()
            if game.isInCollection {
                CoreDataManager.shared.delete(game: game, from: gameCollection)
            } else {
                CoreDataManager.shared.addGameToCollection(from: viewModel)
            }
            game.isInCollection.toggle()
            viewModel.isInCollection?.toggle()
        }
    }
}
