//
//  FoozleSettingsButton.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct FoozleSettingsButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: "gamecontroller")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(.black)
        }
    }
}

// TODO: - change to green checkmark if change to settings happened...
