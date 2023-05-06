//
//  PostingCellView.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI

struct PostingCellView: View {
    
    // MARK: - Properties
    
    @ObservedObject var user: User
    var post: Post
    
    // MARK: - Constants
    
    private struct Constants {
        static let bookmarkSize: CGSize = CGSize(width: 19, height: 24)
        static let cellPadding: CGFloat = 16
        static let descriptionFont: Font = .sfPro(size: 16, weight: .medium)
        static let filterPillsCorner: CGFloat = 4
        static let pillsFont: Font = .sfPro(size: 16, weight: .regular)
        static let positionFont: Font = .sfPro(size: 20, weight: .bold)
    }
    
    // MARK: - UI
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(alignment: .leading) {
                positionLabel
                
                Text(post.employer)
                    .font(Constants.descriptionFont)
                    .padding(.bottom, 16)
                
                Spacer()
                
                filterPillsStack
            }
            .padding(Constants.cellPadding)
        }
    }
    
    private var positionLabel: some View {
        HStack(alignment: .top) {
            Text(post.position)
                .font(Constants.positionFont)

            
            Spacer()
            
            if user.savedPosts.contains(where: { $0.id == post.id }) {
                Image.savvy.bookmarkFill
                    .resizable()
                    .frame(width: Constants.bookmarkSize.width, height: Constants.bookmarkSize.height)
                    .onTapGesture {
                        withAnimation(.default) {
                            user.savedPosts.removeAll { $0.id == post.id }
                        }
                    }
            } else {
                Image.savvy.bookmark
                    .resizable()
                    .frame(width: Constants.bookmarkSize.width, height: Constants.bookmarkSize.height)
                    .onTapGesture {
                        withAnimation(.default) {
                            user.savedPosts.append(post)
                        }
                    }
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
            .font(Constants.pillsFont)
            .foregroundColor(Color.savvy.baseText)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(color)
            .cornerRadius(Constants.filterPillsCorner)
            .lineLimit(1)
    }
    
}

// MARK: - Uncomment below if needed

//struct PostingCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostingCellView(post: DummyData.posts[0])
//    }
//}
