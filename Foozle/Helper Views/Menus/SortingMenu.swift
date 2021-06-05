//
//  SortingMenu.swift
//  Foozle
//
//  Created by Mike Conner on 6/3/21.
//

import SwiftUI

struct SortingMenu: View {
    
    @Binding var sorting: NetworkManager.Sorting
    
    var body: some View {
        HStack {
            Spacer()
            Menu("Sorting") {
                Button("None") { self.sorting = .none }
                Button("Name - Ascending") { self.sorting = .name }
                Button("Name -  Descending") { self.sorting = .reverseName }
                Button("Released - Ascending") { self.sorting = .released }
                Button("Released - Descending") { self.sorting = .reverseReleased }
                Menu("Rating") {
                    Menu("RAWG Rating") {
                        Button("Rating - Ascending") { self.sorting = .rating }
                        Button("Rating - Descending") { self.sorting = .reverseRating }
                    }
                    Menu("Metacritic Rating") {
                        Button("Rating - Ascending") { self.sorting = .metaRating }
                        Button("Rating - Descending") { self.sorting = .reverseMetaRating }
                    }
                }
            }
            .menuStyle(MyMenuStyle())
        }
        .frame(width: 120)
    }
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(sorting: .constant(.name))
    }
}
