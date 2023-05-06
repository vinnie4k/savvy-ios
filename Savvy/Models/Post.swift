//
//  Post.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Foundation

struct Post: Codable {
    let id: Int
    let description: String
    let employer: String
    let howToApply: String
    let link: String
    let position: String
    let qualifications: String
    let tags: [Tag]
    let wage: String
}

struct PostList: Codable {
    let posts: [Post]
}
