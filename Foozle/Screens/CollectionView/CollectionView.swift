//
//  CollectionView.swift
//  Foozle
//
//  Created by Mike Conner on 5/27/21.
//

import SwiftUI

struct CollectionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: CollectionGame.entity(), sortDescriptors: [])
    var gameCollection: FetchedResults<CollectionGame>
    
    @FetchRequest(entity: WishListGame.entity(), sortDescriptors: [])
    var gameWishList: FetchedResults<WishListGame>
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            ViewHeader()
                .ignoresSafeArea()

            Divider()
            
            ZStack {
                Color(.clear)
                Text("My Games (\(gameCollection.count))")
                    .font(Font.title.uppercaseSmallCaps())
            }
            .frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
            
            
            let rows = [GridItem(.flexible()), GridItem(.flexible())]
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    Section(header: FoozleCollectionHeader(imageLabel: "books.vertical")) {
                        ForEach(gameCollection) { game in
                            FoozleCollectionCell(game: game as CollectionGame)
                                .padding(2)
                        }
                    }
                }
                .padding(.bottom, 8)
            }
            .frame(minHeight: UIScreen.screenHeight * 0.3)
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
            
            Divider()
            
            ZStack {
                Color(.clear)
                Text("My Wishlist (\(gameWishList.count))")
                    .font(Font.headline.uppercaseSmallCaps())
            }
            .frame(width: UIScreen.screenWidth, height: 50, alignment: .center)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    Section(header: FoozleCollectionHeader(imageLabel: "gift")) {
                        ForEach(gameWishList) { game in
                            FoozleCollectionCell(game: game as WishListGame)
                                .padding(2)
                        }
                    }
                }
            }
            .frame(minHeight: UIScreen.screenHeight * 0.3)
            .padding(.horizontal, 8)
            Spacer(minLength: 10)
        }        
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(viewModel: FoozleViewModel())
    }
}

