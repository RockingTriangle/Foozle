//
//  CollectionGameDetailView.swift
//  Foozle
//
//  Created by Mike Conner on 6/2/21.
//


import SwiftUI

struct CollectionGameDetailView: View {
        
    @State var game: GameResponse
    @ObservedObject var viewModel: FoozleViewModel
    @Binding var isShowingCollectionDetail: Bool

    @State private var opacity: Double = 0
        
    var stores: [Link<Image>] {
        StoreLinks.displayStoreLinks(game.stores)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 8)
                FoozleCollectionButton(game: game, viewModel: viewModel)
                FoozleWishListButton(game: game, viewModel: viewModel)
                Spacer()
                Button {
                        isShowingCollectionDetail = false
                    } label: {
                        FoozleDismissButton()
                    }
                Spacer()
                    .frame(width: 8)
            }
            Spacer()
                .frame(height: 0)
            Text(game.name)
                .font(.largeTitle)
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 10)
            
            ScrollView {
                GameRemoteImage(urlString: game.backgroundImage ?? "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noResults.png")
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth - 80, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack(alignment: .center) {
                    Text("Where to buy?")
                        .bold()
                        .padding(.top, 8)
                    
                    Spacer()
                        .frame(height: 8)
                                        
                    let rows = [GridItem()]
                    
                    HStack(alignment: .center) {
                        Spacer()
                        if stores.count == 0 {
                            Text("No stores available")
                                .fixedSize()
                        } else if stores.count == 1 {
                            stores[0]
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fit)
                                .background(Color(.white))
                        } else {
                            LazyHGrid(rows: rows, content: {
                                ForEach(0 ..< stores.count) { store in
                                    stores[store]
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(contentMode: .fit)
                                        .background(Color(.white))
                                        .padding(.horizontal, 8)
                                }
                            })
                        }
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Website")
                        .bold()
                    Spacer()
                        .frame(height: 4)
                    
                    if let website = URL(string: viewModel.additionalGameDetail?.website ?? "") {
                        HStack {
                            Link(game.name, destination: website)
                            Image(systemName: "arrowshape.turn.up.right")
                        }
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                    } else {
                        Text("Not available")
                            .padding(.bottom, 8)
                    }
                }
                
                Divider()
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                
                Group {
                    HStack {
                        Spacer()
                            .frame(width: 8)
                        VStack {
                            Spacer()
                            Text("Release Date")
                                .bold()
                            Text(game.displayReleasedData())
                            Spacer()
                            Text("Age Rating")
                                .bold()
                            Text(game.displayESRBData())
                            Spacer()
                            Text("Publisher")
                                .bold()
                            Text((viewModel.additionalGameDetail?.displayPublisherData()) ?? "No data...")
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        
                        Spacer()
                            .frame(width: 8)
                        
                        VStack {
                            Spacer()
                            Text("Genres")
                                .bold()
                            Text(game.displayGenreData())
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("Platforms")
                                .bold()
                            Text(game.displayPlatformData())
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text("Developer")
                                .bold()
                            Text((viewModel.additionalGameDetail?.displayDeveloperData()) ?? "No data...")
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        .frame(minWidth: 0, idealWidth: UIScreen.screenWidth / 2 - 24, maxWidth: UIScreen.screenWidth / 2 - 24, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                    
                }
                
                Divider()
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                Text("About")
                    .bold()
                    .padding(8)
                Text(viewModel.additionalGameDetail?.descriptionRaw ?? "Not available")
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                HStack(spacing: 0) {
                    Spacer()
                    Text("Data provided by ")
                    
                    Link(destination: URL(string: "https://rawg.io/")!, label: {
                        Text("RAWG")
                            .underline()
                    })
                    
                    Spacer()
                }
                .font(Font.system(.caption2).lowercaseSmallCaps())
                .foregroundColor(.gray)
                .padding()
            }
        }
        .opacity(opacity)
        .animate(using: .easeIn(duration: 1), {
            opacity = 1
        })
        .onAppear {
            viewModel.selectedGame = game
            viewModel.getAdditionalGameDetails()
        }
        .frame(width: UIScreen.screenWidth - 48, height: UIScreen.screenHeight * 0.80)
        .background(Color(.systemBackground))
        .cornerRadius(24)
        .shadow(radius: 40)
        Spacer()
            .frame(height: UIScreen.screenHeight / 8)
    }
    
} // End of struct

