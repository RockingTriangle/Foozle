//
//  SortButton.swift
//  Foozle
//
//  Created by Mike Conner on 6/5/21.
//

import SwiftUI

struct SortButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isShowingSortSettings ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: "arrow.up.arrow.down")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isShowingSortSettings ? .white :.black)
        }
        .onTapGesture {
            if viewModel.isShowingSortSettings {
                viewModel.isShowingSortSettings = false
            } else {
                viewModel.isShowingSortSettings = true
            }
        }
    }
}
