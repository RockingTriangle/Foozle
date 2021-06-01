//
//  LoadingView.swift
//  Foozle
//
//  Created by Mike Conner on 5/26/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(.primary)
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
} // End of struct

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ActivityIndicator()
                Spacer()
            }
        }
    }
} // End of struct
