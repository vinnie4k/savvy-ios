//
//  PostDetailView.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI

struct PostDetailView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentation

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var user: User
    var post: Post
    
    // MARK: - UI
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                headerView
                
                Divider()
                    .padding(.vertical, 32)
                
                VStack(alignment: .leading, spacing: 32) {
                    jobDescriptionView
                    
                    qualificationsView
                    
                    wageView
                    
                    if let url = URL(string: post.link) {
                        Link(destination: url) {
                            applyButton
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(TapGesture().onEnded{
                            authViewModel.applyPost(toApply: true, postID: post.id, userID: user.id) { posts in
                                DispatchQueue.main.async {
                                    user.appliedPosts = posts
                                }
                            }
                        })
                    }
                }
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
                if user.savedPosts.contains(where: { $0.id == post.id }) {
                    Image.savvy.bookmarkFill
                        .resizable()
                        .frame(width: 18, height: 24)
                        .onTapGesture {
                            withAnimation(.default) {
                                user.savedPosts.removeAll { $0.id == post.id }
                                authViewModel.bookmarkPost(toSave: false, postID: post.id, userID: user.id) { posts in
                                    DispatchQueue.main.async {
                                        withAnimation(.default) {
                                            user.savedPosts = posts
                                        }
                                    }
                                }
                            }
                        }
                } else {
                    Image.savvy.bookmark
                        .resizable()
                        .frame(width: 18, height: 24)
                        .onTapGesture {
                            withAnimation(.default) {
                                authViewModel.bookmarkPost(toSave: true, postID: post.id, userID: user.id) { posts in
                                    DispatchQueue.main.async {
                                        withAnimation(.default) {
                                            user.savedPosts = posts
                                        }
                                    }
                                }
                            }
                        }
                }
            }
        }
        .padding(20)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(post.position)
                .font(.newYorkSemibold(size: 32))
                .padding(.bottom, 4)
            
            Text(post.employer)
                .font(.sfPro(size: 16, weight: .medium))
                .padding(.bottom, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                filterPillsStack
            }
            .padding(.bottom, 32)
            
            if let url = URL(string: post.link) {
                Link(destination: url) {
                    applyButton
                }
                .buttonStyle(.plain)
                .simultaneousGesture(TapGesture().onEnded{
                    authViewModel.applyPost(toApply: true, postID: post.id, userID: user.id) { posts in
                        DispatchQueue.main.async {
                            user.appliedPosts = posts
                        }
                    }
                })
            }
        }
    }
    
    private var filterPillsStack: some View {
        HStack(spacing: 8) {
            ForEach(post.tags, id: \.id) { tag in
                switch tag.type {
                case .field:
                    filterPills(color: Color.savvy.lightGray, text: tag.name)
                case .location:
                    filterPills(color: Color.savvy.sky, text: tag.name)
                case .payment:
                    filterPills(color: Color.savvy.natural, text: tag.name)
                }
            }
        }
    }
    
    private func filterPills(color: Color, text: String) -> some View {
        Text(text)
            .font(.sfPro(size: 16, weight: .regular))
            .foregroundColor(Color.savvy.baseText)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(color)
            .cornerRadius(8)
    }
    
    private var applyButton: some View {
        ZStack {
            Rectangle()
                .background(Color.savvy.baseText)
                .frame(height: 40)
                .cornerRadius(32)
            
            if user.appliedPosts.contains(where: { $0.id == post.id }) {
                Text("You already applied")
                    .font(.sfPro(size: 16, weight: .regular))
                    .foregroundColor(Color.white)
            } else {
                Text("Apply")
                    .font(.sfPro(size: 16, weight: .regular))
                    .foregroundColor(Color.white)
            }
        }
    }
    
    private var jobDescriptionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Job Description")
                .font(.newYorkMedium(size: 24))
            
            Text(post.description)
                .font(.sfPro(size: 16, weight: .regular))
        }
    }
    
    private var qualificationsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Qualifications")
                .font(.newYorkMedium(size: 24))
            
            Text(post.description)
                .font(.sfPro(size: 16, weight: .regular))
        }
    }
    
    private var wageView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Wage")
                .font(.newYorkMedium(size: 24))
            
            Text("$\(post.wage)")
                .font(.sfPro(size: 16, weight: .regular))
        }
    }
    
}

// MARK: - Uncomment below if needed

//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView(post: DummyData.posts[0])
//    }
//}
