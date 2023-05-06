//
//  DummyData.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Foundation

// TODO: REMOVE DUMMY DATA
struct DummyData {
    
    static let posts = [
        Post(
            id: 1,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            employer: "Cornell AppDev",
            howToApply: "Website",
            link: "https://vinbui.me",
            position: "iOS Developer",
            qualifications: "Graduation 2025 or later",
            tags: tags,
            wage: "25/hr"
        ),
        Post(
            id: 2,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            employer: "Cornell AppDev",
            howToApply: "Website",
            link: "https://vinbui.me",
            position: "iOS Developer",
            qualifications: "Graduation 2025 or later",
            tags: tags,
            wage: "25/hr"
        ),
        Post(
            id: 3,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            employer: "Cornell AppDev",
            howToApply: "Website",
            link: "https://vinbui.me",
            position: "iOS Developer",
            qualifications: "Graduation 2025 or later",
            tags: tags,
            wage: "25/hr"
        ),
        Post(
            id: 4,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            employer: "Cornell AppDev",
            howToApply: "Website",
            link: "https://vinbui.me",
            position: "iOS Developer",
            qualifications: "Graduation 2025 or later",
            tags: tags,
            wage: "25/hr"
        ),
    ]
    
    static var mainUser = User(id: 1, appliedPosts: [], imgUrl: URL(string: "https://scontent.cdninstagram.com/v/t51.2885-19/222047372_264345962120146_7429469079747555586_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent.cdninstagram.com&_nc_cat=110&_nc_ohc=s6YV1qWgQ-wAX93Avr3&edm=APs17CUBAAAA&ccb=7-5&oh=00_AfCcoNSA1ICR0dgQFNNTZol2UIxPks__pJRIbC0TeEHYTw&oe=645B17BF&_nc_sid=978cb9")!, name: "", netid: "", savedPosts: [])
    
    static let tags = [
        Tag(id: 1, name: "Paid", type: .payment),
        Tag(id: 2, name: "Remote", type: .location),
        Tag(id: 3, name: "Developer", type: .field)
    ]
    
}
