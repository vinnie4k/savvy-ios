//
//  User.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Foundation

class User: ObservableObject {
    @Published var id: String
    @Published var appliedPosts: [Post]
    @Published var imgUrl: URL
    @Published var name: String
    @Published var netid: String
    @Published var savedPosts: [Post]
    
    init(id: String, appliedPosts: [Post], imgUrl: URL, name: String, netid: String, savedPosts: [Post]) {
        self.id = id
        self.appliedPosts = appliedPosts
        self.imgUrl = imgUrl
        self.name = name
        self.netid = netid
        self.savedPosts = savedPosts
    }
}
