//
//  User.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import Foundation
class User: Codable {
    var id: Int
    var name: String
    var netid: String
    var password: String
    var interests: [String]
    var posts: [Post]
    
    init(id: Int, name: String, netid: String, password: String, posts: [Post], interests: [String]) {
        self.id = id
        self.name = name
        self.netid = netid
        self.password = password
        self.posts = posts
        self.interests = interests
    }
}
let user1 = User(id: 1, name: "Alice", netid: "jy865", password: "password1", posts: [post1, post2, post3], interests: ["Internship","CS"])
let user2 = User(id: 2, name: "Bob", netid: "bb123", password: "password2", posts: [post2, post3], interests: ["FWS"])
let user3 = User(id: 3, name: "Charlie", netid: "cu789", password: "password3", posts: [post3, post4], interests: ["Biology", "Community"])
let users = [user1, user2, user3]
