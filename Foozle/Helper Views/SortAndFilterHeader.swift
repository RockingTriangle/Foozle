//
//  SortAndFilterHeader.swift
//  Foozle
//
//  Created by Mike Conner on 6/4/21.
//

import SwiftUI

struct SortAndFilterHeader: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Platroms").bold()
                Text(viewModel.platformSetting.titleDescription)
            }
            Spacer()
            VStack {
                Text("Genres").bold()
                Text(viewModel.genreSetting.titleDescription)
            }
            Spacer()
            VStack {
                Text("Sorting").bold()
                HStack {
                    Text(viewModel.sortingSetting.titleDescription)
                    if  viewModel.sortingSetting == .none {
                        Text("🚫")
                    } else if (viewModel.sortingSetting == .reverseName) ||
                              (viewModel.sortingSetting == .reverseRating) ||
                              (viewModel.sortingSetting == .reverseReleased) {
                        Image(systemName: "arrow.down")
                    } else {
                        Image(systemName: "arrow.up")
                    }
                }
            }
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

struct SortAndFilterHeader_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterHeader(viewModel: FoozleViewModel())
    }
}
