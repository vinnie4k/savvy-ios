//
//  User.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Foundation

class User: ObservableObject, Codable {
    
    static let shared = DummyData.mainUser
    
    @Published var id: Int
    @Published var appliedPosts: [Post]
    @Published var imgUrl: URL
    @Published var name: String
    @Published var netid: String
    @Published var savedPosts: [Post]
    
    init(id: Int, appliedPosts: [Post], imgUrl: URL, name: String, netid: String, savedPosts: [Post]) {
        self.id = id
        self.appliedPosts = appliedPosts
        self.imgUrl = imgUrl
        self.name = name
        self.netid = netid
        self.savedPosts = savedPosts
    }
        
    enum CodingKeys: CodingKey {
        case id, postsApplied, imgUrl, name, netid, postsSaved
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        appliedPosts = try container.decode([Post].self, forKey: .postsApplied)
        imgUrl = try container.decode(URL.self, forKey: .imgUrl)
        name = try container.decode(String.self, forKey: .name)
        netid = try container.decode(String.self, forKey: .netid)
        savedPosts = try container.decode([Post].self, forKey: .postsSaved)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(appliedPosts, forKey: .postsApplied)
        try container.encode(imgUrl, forKey: .imgUrl)
        try container.encode(name, forKey: .name)
        try container.encode(netid, forKey: .netid)
        try container.encode(savedPosts, forKey: .postsSaved)
    }
    
}
