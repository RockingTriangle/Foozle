//
//  SearchBarView.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    @State private var isEditing = false
    @ObservedObject var viewModel: FoozleViewModel

    var body: some View {
        HStack(alignment: .center) {            
            TextField("Search...", text: $text, onCommit: {
                viewModel.searchText = text
                viewModel.getGamesForSearchView()
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                viewModel.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .animation(.default)
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    viewModel.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), viewModel: FoozleViewModel())
    }
}
