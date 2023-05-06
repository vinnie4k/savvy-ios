//
//  SearchBarView.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI
 
struct SearchBar: View {
    
    @State private var isEditing = false
    @Binding var submittedText: String
    @Binding var text: String
 
    var body: some View {
        HStack {
            Image.savvy.magnifyingGlass
                .foregroundColor(Color.savvy.baseText)
                .frame(width: 12, height: 12)
            
            TextField("Search for jobs", text: $text)
                .foregroundColor(Color.savvy.baseText)
                .tint(Color.savvy.baseText)
                .padding(10)
                .onTapGesture {
                    self.isEditing = true
                    self.submittedText = ""
                }
                .onSubmit {
                    self.submittedText = text
                    self.text = ""
                    self.isEditing = false
                }
 
            if isEditing {
                Button {
                    withAnimation(.default) {
                        self.isEditing = false
                        self.text = ""
                    }
                } label: {
                    Image.savvy.cross
                        .foregroundColor(Color.savvy.baseText)
                        .frame(width: 12, height: 12)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(8)
    }
}
