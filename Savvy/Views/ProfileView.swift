//
//  ProfileView.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var user: User
    
    // MARK: - UI
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                headerView
                
                bookmarksView
                
                jobsAppliedView
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image.savvy.backArrow
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        presentation.wrappedValue.dismiss()
                    }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Sign Out")
                    .font(.newYorkMedium(size: 16))
                    .foregroundColor(Color.savvy.baseText)
                    .onTapGesture {
                        authViewModel.signOut()
                    }
            }
        }
        .padding(20)
        .background(Color.savvy.background)
    }
    
    private var headerView: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: user.imgUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Rectangle()
                    .background(.gray)
            }
            .frame(width: 88, height: 88)
            .cornerRadius(11)
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.newYorkMedium(size: 32))
                
                Text(user.netid)
                    .font(.newYorkMedium(size: 20))
            }
            
            Spacer()
        }
    }
    
    private var bookmarksView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Bookmarks")
                .font(.newYorkMedium(size: 24))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(user.savedPosts, id: \.id) { post in
                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {
                            PostingCellView(post: post)
                                .frame(width: 323, height: 156)
                                .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    private var jobsAppliedView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Jobs Applied")
                .font(.newYorkMedium(size: 24))
            
            ForEach(user.appliedPosts, id: \.id) { post in
                NavigationLink {
                    PostDetailView(post: post)
                } label: {
                    PostingCellView(post: post)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
}
