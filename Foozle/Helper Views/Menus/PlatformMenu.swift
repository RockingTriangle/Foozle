//
//  PlatformMenu.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct PlatformMenu: View {
    
    @ObservedObject var viewModel: FoozleViewModel    
    @Binding var platforms: NetworkManager.Platforms
    
    @State var frameHeight = 0
    @State var opacity = 0.0
    
    var body: some View {
        HStack {
            Spacer()
            Menu("Platforms") {
                Button("All") { self.platforms = .all }
                Button("Computer") { self.platforms = .computer}
                Button("PlayStation") { self.platforms = .playstation}
                Button("Xbox") { self.platforms = .xbox }
                Button("Nintendo") { self.platforms = .nintendo }
                Button("Mobile") { self.platforms = .mobile }
            }
            .menuStyle(MyMenuStyle())
        }
        .frame(width: 120)
        .frame(height: CGFloat(frameHeight))
        .opacity(opacity)
        .onAppear {
            withAnimation(.linear(duration: 0.3)) {
                frameHeight = 40
            }
            withAnimation(.easeIn(duration: 0.3).delay(0.3)) {
                opacity = 1
            }
            viewModel.isShowingCalendarSettings = false
            viewModel.isShowingSortSettings = false
            viewModel.isShowingGenreSettings = false
        }
    }
}

struct PlatformMenu_Previews: PreviewProvider {
    static var previews: some View {
        PlatformMenu(viewModel: FoozleViewModel(), platforms: .constant(.playstation))
    }
}
