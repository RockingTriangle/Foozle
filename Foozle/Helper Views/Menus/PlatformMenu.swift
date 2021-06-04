//
//  PlatformMenu.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct PlatformMenu: View {
    
    @Binding var platforms: NetworkManager.Platforms
    
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
    }
}

struct PlatformMenu_Previews: PreviewProvider {
    static var previews: some View {
        PlatformMenu(platforms: .constant(.playstation))
    }
}
