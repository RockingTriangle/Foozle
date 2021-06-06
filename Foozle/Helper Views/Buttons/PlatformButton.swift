//
//  PlatformButton.swift
//  Foozle
//
//  Created by Mike Conner on 6/5/21.
//

import SwiftUI

struct PlatformButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isShowingPlatformSettings ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: "gamecontroller")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isShowingPlatformSettings ? .white :.black)
        }
        .onTapGesture {
            if viewModel.isShowingPlatformSettings {
                viewModel.isShowingPlatformSettings = false
            } else {
                viewModel.isShowingPlatformSettings = true
            }
        }
    }
}
