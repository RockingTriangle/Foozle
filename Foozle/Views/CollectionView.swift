//
//  CollectionView.swift
//  Foozle
//
//  Created by Mike Conner on 5/27/21.
//

import SwiftUI

struct CollectionView: View {
    
    @FetchRequest(entity: CollectionGame.entity(), sortDescriptors: [])
    var gameCollection: FetchedResults<CollectionGame>
    
    @FetchRequest(entity: WishListGame.entity(), sortDescriptors: [])
    var gameWishList: FetchedResults<WishListGame>
    
    @ObservedObject var viewModel: FoozleViewModel
    
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            Group {
                VStack(alignment: .center, spacing: 0) {
                    Group {
                        FoozleHeaderView()
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
                                            .onTapGesture {
                                                viewModel.collectionViewSlugName = game.slug
                                                viewModel.getCollectionViewGameDetails(collection: true, wishList: false)
                                            }
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
                                .font(Font.title.uppercaseSmallCaps())
                        }
                        .frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
                                Section(header: FoozleCollectionHeader(imageLabel: "gift")) {
                                    ForEach(gameWishList) { game in
                                        FoozleCollectionCell(game: game as WishListGame)
                                            .padding(2)
                                            .onTapGesture {
                                                viewModel.collectionViewSlugName = game.slug
                                                viewModel.getCollectionViewGameDetails(collection: false, wishList: true)
                                            }
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
            .blur(radius: viewModel.isShowingCollectionDetail ? 20 : 0)
            if viewModel.isShowingCollectionDetail {
                CollectionGameDetailView(game: viewModel.selectedGame!, viewModel: viewModel, isShowingCollectionDetail: $viewModel.isShowingCollectionDetail)
            }
        }
        .opacity(opacity)
        .animate(using: .easeIn(duration: 1), {
            opacity = 1
        })
        .onAppear {
            viewModel.isShowingSortSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
            viewModel.isShowingCalendarSettings = false
        }
        .onDisappear {
            viewModel.isShowingCollectionDetail = false
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(viewModel: FoozleViewModel())
    }
}

