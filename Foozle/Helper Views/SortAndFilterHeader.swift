//
//  SortAndFilterHeader.swift
//  Foozle
//
//  Created by Mike Conner on 6/4/21.
//

import SwiftUI

struct SortAndFilterHeader: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    @State var animate = false
    
    var body: some View {
        HStack {
            Group {
                Spacer()
                SortButton(viewModel: viewModel)
                Spacer()
                PlatformButton(viewModel: viewModel)
                Spacer()
            }
            Group {
                GenreButton(viewModel: viewModel)
                Spacer()
                CalendarButton(viewModel: viewModel)
                Spacer()
                RefreshButton(viewModel: viewModel)
                Spacer()
            }
        }
    }
}

struct SortAndFilterHeader_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterHeader(viewModel: FoozleViewModel())
    }
}
