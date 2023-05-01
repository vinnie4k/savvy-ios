//
//  Recruiter.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import Foundation
class Recruiter: Codable {
    var id: Int
    var name: String
    var email: String
    var organization: String
    var posts: [Post]
    
    init(id: Int, name: String, email: String, organization: String, posts: [Post], interests: [String]) {
        self.id = id
        self.name = name
        self.email = email
        self.organization = organization
        self.posts = posts
    }
}
