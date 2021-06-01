//
//  FoozleCollectionHeader.swift
//  Foozle
//
//  Created by Mike Conner on 5/29/21.
//

import SwiftUI

struct FoozleCollectionHeader: View {
    
    var imageLabel: String
      
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: imageLabel)
                .font(.title)
                .foregroundColor(.secondary)
            Spacer()
        }
        .frame(width: 40)
        .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary)
                        .opacity(0.3))
    }
}

struct FoozleCollectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        FoozleCollectionHeader(imageLabel: "books.vertical")
    }
}
