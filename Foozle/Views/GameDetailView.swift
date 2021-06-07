//
//  GameDetailView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct GameDetailView: View {
        
    @State var game: GameResponse
    @ObservedObject var viewModel: FoozleViewModel
    @Binding var isShowingDetail: Bool

    @State private var opacity: Double = 0
        
    var stores: [Link<Image>] {
        StoreLinks.displayStoreLinks(game.stores)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 8)
                CollectionButton(game: game, viewModel: viewModel)
                WishListButton(game: game, viewModel: viewModel)
                Spacer()
                DismissButton(viewModel: viewModel)
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
                if let backgroundImage = game.backgroundImage {
                    GameRemoteImage(urlString: backgroundImage)
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth - 80, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                } else {
                    GameRemoteImage(urlString: "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noImage.png")
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth - 80, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                
                VStack(alignment: .center) {
                    Text("Where to buy?")
                        .bold()
                        .padding(.top, 8)
                    
                    Spacer()
                        .frame(height: 8)
                                        
                    let row = [GridItem(.fixed(30))]
                    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]
                    
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
                        } else if stores.count < 5 {
                            LazyHGrid(rows: row, content: {
                                ForEach(0 ..< stores.count) { store in
                                    stores[store]
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(contentMode: .fit)
                                        .background(Color(.white))
                                        .padding(8)
                                }
                            })
                        } else {
                            LazyHGrid(rows: rows, content: {
                                ForEach(0 ..< stores.count) { store in
                                    stores[store]
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(contentMode: .fit)
                                        .background(Color(.white))
                                        .padding(8)
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
                            let arrow = Image(systemName: "arrowshape.turn.up.right")
                            Link("\(game.name) \(arrow)", destination: website)
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
            .blur(radius: viewModel.isLoading ? 20 : 0)
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .opacity(opacity)
        .animate(using: .easeIn(duration: 1), {
            opacity = 1
        })
        .onAppear {
            viewModel.selectedGame = game
            viewModel.getAdditionalGameDetails()
            viewModel.isShowingSortSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
            viewModel.isShowingCalendarSettings = false
        }
        .frame(width: UIScreen.screenWidth - 48, height: UIScreen.screenHeight * 0.80)
        .background(Color(.systemBackground))
        .cornerRadius(24)
        .shadow(radius: 40)
        .offset(x: 0, y: -UIScreen.screenHeight * 0.04)
        Spacer()
            .frame(height: UIScreen.screenHeight / 8)
    }
    
} // End of struct
