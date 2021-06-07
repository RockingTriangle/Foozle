//
//  FoozleCollectionCell.swift
//  Foozle
//
//  Created by Mike Conner on 5/29/21.
//

import SwiftUI

struct FoozleCollectionCell<T: AnyCollectionType>: View {
    
    let game: T
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                GameRemoteImage(urlString: game.backgroundImage)
                    .scaledToFill()
            }
            .frame(width: UIScreen.screenWidth * 0.3, alignment: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Text(game.name)
                .foregroundColor(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.4)
                .frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.03, alignment: .center)
        }
    }
}
