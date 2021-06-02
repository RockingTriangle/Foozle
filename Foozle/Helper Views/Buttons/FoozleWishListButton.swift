//
//  FoozleWishListButton.swift
//  Foozle
//
//  Created by Mike Conner on 5/30/21.
//

import SwiftUI

struct FoozleWishListButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isOnWishList ?? false ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: viewModel.isOnWishList ?? false ? "gift.fill" : "gift")
                .imageScale(.medium)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isOnWishList ?? false ? .white : .black)
        }
        .onAppear {

        }
    }
}
