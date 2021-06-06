//
//  PinnedView.swift
//  Foozle
//
//  Created by Mike Conner on 5/29/21.
//

import SwiftUI

struct PinnedView: View {
    
    var count: Int
    var imageLabel: String
      
    var body: some View {
        VStack {
            Spacer()
            Group {
                Text("\(count)")
                Text(" - ")
                Image(systemName: imageLabel)
            }
                .font(.title)
                .foregroundColor(.primary)
                .rotationEffect(Angle(degrees: -90))
            Spacer()
        }
        .frame(width: 40)
        .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.secondary)
                        .opacity(0.3))
    }
}

struct FoozleCollectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        PinnedView(count: 3, imageLabel: "books.vertical")
    }
}
