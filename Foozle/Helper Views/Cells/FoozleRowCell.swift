//
//  FoozleCell.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct FoozleRowCell: View {
    
    var game: GameResponse
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                GameRemoteImage(urlString: game.backgroundImage ?? "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noResults.png")
                    .scaledToFill()
                Rectangle()
                    .foregroundColor(Color(.sRGB, white: 1.0, opacity: 0.6))
                    .frame(width: UIScreen.screenWidth * 0.9, height: 40, alignment: .center)
                Text(game.name)
                    .foregroundColor(.primary)
                    .font(.title)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                    .padding(.bottom, 5)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
            .frame(width: UIScreen.screenWidth * 0.9, height: 175, alignment: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}

struct FoozleCell_Previews: PreviewProvider {
    static var previews: some View {
        FoozleRowCell(game: GameResponse(id: 1, slug: "test", name: "test", backgroundImage: "test", released: "today", platforms: [], genres: [], stores: [], esrbRating: ESRBRating(id: 1, name: "mature")))
    }
}
