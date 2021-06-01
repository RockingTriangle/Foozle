//
//  FoozleCollectionButton.swift
//  Foozle
//
//  Created by Mike Conner on 5/30/21.
//

import SwiftUI

struct FoozleCollectionButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isInCollection ?? false ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: viewModel.isInCollection ?? false ? "books.vertical.fill" : "books.vertical")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isInCollection ?? false ? .white : .black)
        }
        .onAppear {
            
        }
    }
}

//struct FoozleCollectionButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FoozleCollectionButton(isInCollection: true)
//    }
//}
