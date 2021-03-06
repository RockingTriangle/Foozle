//
//  View+Ext.swift
//  Foozle
//
//  Created by Mike Conner on 5/28/21.
//

import SwiftUI

extension View {
    
    func animate(using animation: Animation = Animation.easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
} // End of extension
