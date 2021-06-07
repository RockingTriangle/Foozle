//
//  MenuStyle.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct MyMenuStyle: MenuStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .frame(width: 120)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.tertiarySystemFill))
            )
    }
} // End of struct
