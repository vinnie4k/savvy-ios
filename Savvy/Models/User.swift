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
    var classYear: String
    var savedPosts: [Post]
    var savedTags: [Tag]
    var appliedPosts: [Post]
    
    
    
    
    init(id: Int, name: String, netid: String, password: String, classYear: String, savedTags: [Tag]) {
        self.id = id
        self.name = name
        self.netid = netid
        self.password = password
        self.savedPosts = []
        self.classYear = classYear
        self.savedTags = savedTags
        self.appliedPosts = []
    }
    
}
let user1 = User(
    id: 1,
    name: "Jenny Yu",
    netid: "jy865",
    password: "password1",
    classYear: "2025",
    savedTags: [
        Tag(label: "Computer Science", type: "Field" ),
        Tag(label: "Engineering", type: "Field"),
        Tag(label: "Art", type: "Field"),
        Tag(label: "Health", type: "Field"),
        Tag(label: "Agriculture", type: "Field")
    ])
let user2 = User(
    id: 2,
    name: "Liam Du",
    netid: "ld386",
    password: "password2",
    classYear: "2024",
    savedTags: [
        Tag(label: "Computer Science", type: "Field" ),
        Tag(label: "Engineering", type: "Field"),
        Tag(label: "FWS", type: "Qualifications"),
        Tag(label: "Paid", type: "Payment"),
        Tag(label: "Internship", type: "Qualifications")
    ])
let user3 = User(
    id: 3, name: "Charlie",
    netid: "cu789",
    password: "password3",
    classYear: "2026",
    savedTags:[
        Tag(label: "Computer Science", type: "Field" ),
        Tag(label: "Engineering", type: "Field"),
        Tag(label: "Art", type: "Field"),
        Tag(label: "Health", type: "Field"),
        Tag(label: "Agriculture", type: "Field")
    ])

let users = [user1, user2, user3]
