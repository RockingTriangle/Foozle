//
//  ViewHeader.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct ViewHeader: View {
    var body: some View {
        let gradient = Gradient(colors: [.white, .gray, .white, .gray, .white, .gray, .white])
        let nonCenteredAngularGradient = AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(160), endAngle: .degrees(380))
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(nonCenteredAngularGradient)
            VStack {
                Text("Foozle")
                    .font(Font.system(size: 48).uppercaseSmallCaps())
                    .foregroundColor(.primary)
                    .bold()
                HStack(spacing: 0) {
                    Spacer()
                    Text("Data provided by ")
                    
                    Link(destination: URL(string: "https://rawg.io/")!, label: {
                        Text("RAWG")
                            .underline()
                    })
                    
                    Spacer()
                }
                    .font(Font.system(.caption2).lowercaseSmallCaps())
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .frame(height: UIScreen.screenHeight / 7)
        .padding(.bottom, -50)
    }
}

struct ViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        ViewHeader()
    }
}
