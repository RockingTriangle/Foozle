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
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Platforms").bold()
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
                                    (viewModel.sortingSetting == .reverseReleased) ||
                                    (viewModel.sortingSetting == .reverseMetaRating) {
                            Image(systemName: "arrow.down")
                        } else {
                            Image(systemName: "arrow.up")
                        }
                    }
                }
                Spacer()
            }
            .multilineTextAlignment(.center)
            if viewModel.dateRange == "" {
                Text("Date Range  -  All dates")
            } else {
                Text("Date range  -  From:\(viewModel.startingDate) - To:\(viewModel.endingDate)")
            }
        }
    }
}

struct SortAndFilterHeader_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterHeader(viewModel: FoozleViewModel())
    }
}
