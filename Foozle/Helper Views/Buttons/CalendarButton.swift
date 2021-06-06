//
//  CalendarButton.swift
//  Foozle
//
//  Created by Mike Conner on 6/5/21.
//

import SwiftUI

struct CalendarButton: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(viewModel.isShowingCalendarSettings ? Color(.black) : Color(.systemGray5))
                .opacity(0.6)
            Image(systemName: "calendar.badge.clock")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(viewModel.isShowingCalendarSettings ? .white :.black)
        }
        .onTapGesture {
            if viewModel.isShowingCalendarSettings {
                viewModel.isShowingCalendarSettings = false
            } else {
                viewModel.isShowingCalendarSettings = true
            }
        }
    }
}
