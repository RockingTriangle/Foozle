//
//  WishListButton.swift
//  Foozle
//
//  Created by Mike Conner on 5/30/21.
//

import SwiftUI

struct WishListButton: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: WishListGame.entity(), sortDescriptors: [])
    var gameWishList: FetchedResults<WishListGame>
        
    @State var game: GameResponse
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isOnWishList ?? false ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: viewModel.isOnWishList ?? false ? "gift.fill" : "gift")
                .imageScale(.medium)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isOnWishList ?? false ? .white : .black)
        }
        .onAppear{
            for selectedGame in gameWishList {
                if selectedGame.name == game.name {
                    game.isOnWishList = true
                    viewModel.isOnWishList = true
                    break
                } else {
                    game.isOnWishList = false
                    viewModel.isOnWishList = false
                }
            }
        }
        .onTapGesture {
            viewModel.refresh.toggle()
            if game.isOnWishList {
                CoreDataManager.shared.delete(game: game, from: gameWishList)
            } else {
                CoreDataManager.shared.addGameToWishList(from: viewModel)
            }
            game.isOnWishList.toggle()
            viewModel.isOnWishList?.toggle()
        }
    }
}
