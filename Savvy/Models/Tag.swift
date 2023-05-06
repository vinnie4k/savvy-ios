//
//  Tag.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Foundation

struct Tag: Equatable, Codable {
    let id: Int
    let name: String
    let type: TagType
}

enum TagType: String, Codable {
    case field, location, payment
}
