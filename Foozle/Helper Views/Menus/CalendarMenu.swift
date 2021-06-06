//
//  CalendarMenu.swift
//  Foozle
//
//  Created by Mike Conner on 6/5/21.
//

import SwiftUI

struct CalendarMenu: View {
    
    @ObservedObject var viewModel: FoozleViewModel
    
    @Binding var startingDate: Date
    @Binding var endingDate: Date
    
    @State var frameHeight = 0
    @State var opacity = 0.0
    @Binding var searchRange: Bool
    
    var body: some View {
        HStack {
            Toggle("", isOn: $searchRange)
                .position(CGPoint(x: 20, y: 20))
            
            Spacer()
            Group {
                DatePicker("Start:",
                           selection: $startingDate,
                           in: ...endingDate,
                           displayedComponents: .date)
                    .labelsHidden()
                
                Text("-")
                    .padding(.horizontal, 8)
                
                DatePicker("End:",
                           selection: $endingDate,
                           in: startingDate...,
                           displayedComponents: .date)
                    .labelsHidden()
            }
            .disabled(!searchRange)
        }
        .padding(.horizontal)
        .frame(height: CGFloat(frameHeight))
        .opacity(opacity)
        .onAppear {
            withAnimation(.linear(duration: 0.3)) {
                frameHeight = 40
            }            
            withAnimation(.easeIn(duration: 0.3).delay(0.3)) {
                opacity = 1
            }
            viewModel.isShowingSortSettings = false
            viewModel.isShowingPlatformSettings = false
            viewModel.isShowingGenreSettings = false
        }
    }
}

struct CalendarMenu_Previews: PreviewProvider {
    static var previews: some View {
        CalendarMenu(viewModel: FoozleViewModel(), startingDate: .constant(Date()), endingDate: .constant(Date()), searchRange: .constant(true))
    }
}
