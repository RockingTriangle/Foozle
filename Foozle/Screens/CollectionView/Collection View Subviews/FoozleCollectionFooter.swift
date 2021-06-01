//
//  FoozleCollectionFooter.swift
//  Foozle
//
//  Created by Mike Conner on 5/29/21.
//

import SwiftUI

struct FoozleCollectionFooter: View {
    
    var amountOfGames: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Total Games:")
                Text(amountOfGames)
            }
            .fixedSize()
            .rotationEffect(Angle(degrees: 270))
            .font(Font.system(size: 24, weight: .semibold, design: .default))
            .foregroundColor(.secondary)
            Spacer()
        }
        .frame(width: 40)
        .background(RoundedRectangle(cornerRadius: 12.0)
                        .fill(Color.gray)
                        .opacity(0.3))
    }
}

struct FoozleCollectionCellFooter_Previews: PreviewProvider {
    static var previews: some View {
        FoozleCollectionFooter(amountOfGames: "8")
    }
}
