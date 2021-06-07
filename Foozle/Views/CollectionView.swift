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
        let rows = [GridItem(.flexible()), GridItem(.flexible())]
        ZStack {
            Group {
                VStack(alignment: .center, spacing: 0) {
                    Group {
                        FoozleHeaderView()
                            .ignoresSafeArea()
                            .padding(.top, -50)
                        Divider()
                            .padding(.vertical, 8)
                        GeometryReader { geometry in
//                            Spacer()
                            VStack {
                                ScrollView(.horizontal) {
                                    LazyHGrid(rows: rows) {
                                        Section(header: PinnedView(count: gameCollection.count, imageLabel: "books.vertical")) {
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
                                }
                                .frame(height: UIDevice.hasNotch ? geometry.size.height * 0.475 : geometry.size.height * 0.45)
                                .padding(.horizontal, 8)
                                
                                Divider()
                                    .padding(4)
                                
                                ScrollView(.horizontal) {
                                    LazyHGrid(rows: rows) {
                                        Section(header: PinnedView(count: gameWishList.count, imageLabel: "gift")) {
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
                                .frame(height: UIDevice.hasNotch ? geometry.size.height * 0.475 : geometry.size.height * 0.45)
                                .padding(.horizontal, 8)
                            }
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
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(viewModel: FoozleViewModel())
    }
}

