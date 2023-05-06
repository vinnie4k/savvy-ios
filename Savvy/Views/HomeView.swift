//
//  HomeView.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var user: User
    @StateObject private var viewModel: ViewModel = ViewModel()
    
    // MARK: - Constants
    
    private struct Constants {
        static let cellRadius: CGFloat = 8
        static let crossSize: CGSize = CGSize(width: 12, height: 12)
        static let forYouCellSize: CGSize = CGSize(width: 323, height: 140)
        static let profileImgRadius: CGFloat = 8
        static let profileImgSize: CGSize = CGSize(width: 64, height: 64)
        static let scrollViewSpacing: CGFloat = 16
        static let padding: CGFloat = 20
        static let tagsCorner: CGFloat = 4
        static let tagsFont: Font = .sfPro(size: 16, weight: .regular)
    }
    
    // MARK: - UI
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: Constants.scrollViewSpacing) {
                    headerView
                    
                    forYouSection
                    
                    browseSection
                }
            }
            .padding(Constants.padding)
            .background(Color.savvy.background)
            .onChange(of: viewModel.submittedText) { newText in
                if newText != "" {
                    viewModel.addTag(text: newText)
                }
            }
            .onAppear {
                viewModel.setupEnvironment(user: user)
                viewModel.fetchAllPosts()
            }
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack(spacing: 16) {
            AsyncImage(url: user.imgUrl) { image in
                NavigationLink {
                    ProfileView()
                } label: {
                    image
                        .resizable()
                }
            } placeholder: {
                Rectangle()
                    .background(.gray)
            }
            .frame(width: Constants.profileImgSize.width, height: Constants.profileImgSize.height)
            .cornerRadius(Constants.profileImgRadius)
            
            VStack(alignment: .leading) {
                Text("Good morning!")
                    .font(.sfPro(size: 16, weight: .medium))
                
                Text(user.name)
                    .font(.newYorkMedium(size: 32))
            }
            
            Spacer()
        }
        .padding(.bottom, Constants.scrollViewSpacing)
    }
    
    @ViewBuilder
    private var forYouSection: some View {
        Text("For you")
            .font(.newYorkMedium(size: 24))
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.postings, id: \.id) { post in
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        PostingCellView(post: post)
                            .frame(width: Constants.forYouCellSize.width, height: Constants.forYouCellSize.height)
                            .cornerRadius(Constants.cellRadius)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    @ViewBuilder
    private var browseSection: some View {
        Text("Browse")
            .font(.newYorkMedium(size: 24))
        
        SearchBar(submittedText: $viewModel.submittedText, text: $viewModel.searchText)
        
        VStack(alignment: .leading, spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.searchTags, id: \.self) { text in
                        searchTag(text: text)
                    }
                }
            }
            
            Text("\(viewModel.postings.count) Opportunities Available")
                .font(.sfPro(size: 16, weight: .medium))
            
            postingsView
        }
    }
    
    private func searchTag(text: String) -> some View {
        HStack {
            Text(text)
                .font(Constants.tagsFont)
                .padding(.trailing, 10)
                .foregroundColor(Color.savvy.baseText)
            
            Spacer()
            
            Image.savvy.cross
                .resizable()
                .foregroundColor(Color.savvy.gray)
                .frame(width: Constants.crossSize.width, height: Constants.crossSize.height)
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.removeTag(text: text)
                    }
                }
        }
        .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
        .background(Color.savvy.lightGray)
        .cornerRadius(Constants.tagsCorner)
    }
    
    private var postingsView: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.postings, id: \.id) { post in
                NavigationLink {
                    PostDetailView(post: post)
                } label: {
                    PostingCellView(post: post)
                        .cornerRadius(Constants.cellRadius)
                }
                .buttonStyle(.plain)
            }
        }
        .onChange(of: viewModel.searchTags) { _ in
            if viewModel.searchTags.isEmpty {
                viewModel.fetchAllPosts()
            } else {
                viewModel.fetchFilteredPosts()
            }
        }
    }

}

// MARK: - Uncomment below if needed

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
