//
//  HomeViewModel.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Combine
import SwiftUI

extension HomeView {
    
    @MainActor
    class ViewModel: ObservableObject {
        
        // MARK: - Properties
        
        @Published var postings: [Post] = []
        @Published var searchTags: [String] = []
        @Published var searchText: String = ""
        @Published var submittedText: String = ""
        
        private var queryBag = Set<AnyCancellable>()
        private var user: User?
        
        // MARK: - Property Helpers
        
        func setupEnvironment(user: User) {
            if self.user == nil {
                self.user = user
            }
        }
        
        // MARK: - Requests
        
        func fetchAllPosts() {
            guard let url = URL(string: "http://34.150.213.122/api/posts/") else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap { data, response in
                    guard let response = response as? HTTPURLResponse,
                          response.statusCode >= 200 && response.statusCode < 300 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: PostList.self, decoder: decoder)
                .sink { completion in
                    print("Fetching posts: \(completion)")
                } receiveValue: { [weak self] postList in
                    var newPostings: [Post] = postList.posts
                    
                    self?.searchTags.forEach { text in
                        newPostings = newPostings.filter {
                            $0.position.lowercased().contains(text.lowercased())
                        }
                    }
                    
                    self?.postings = newPostings
                }
                .store(in: &queryBag)
        }
        
        func fetchFilteredPosts() {
            filterPostings()
        }
        
        // MARK: - Helpers
        
        func addTag(text: String) {
            if !searchTags.contains(text) {
                searchTags.append(text)
            }
            filterPostings()
        }
        
        func removeTag(text: String) {
            searchTags.removeAll { $0 == text }
            filterPostings()
        }
        
        private func filterPostings() {
            fetchAllPosts()
            var newPostings: [Post] = postings
            
            searchTags.forEach { text in
                newPostings = newPostings.filter {
                    $0.position.lowercased().contains(text.lowercased())
                }
            }
            
            postings = newPostings
        }
        
    }
    
}
