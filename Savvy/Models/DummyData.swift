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
    
    static var mainUser = User(id: "1", appliedPosts: [], imgUrl: URL(string: "https://scontent.cdninstagram.com/v/t51.2885-19/339071643_744206047348735_5531904404055109699_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent.cdninstagram.com&_nc_cat=107&_nc_ohc=FCUGSc_cK9YAX8AlqXy&edm=APs17CUBAAAA&ccb=7-5&oh=00_AfDJNlZmEoyHOQW9z2FJjR9-0oxL8T7d8g8oEM8DIJaJCw&oe=645A2CDC&_nc_sid=978cb9")!, name: "Reade Plunkett", netid: "rwp227", savedPosts: [])
    
    static let tags = [
        Tag(id: 1, name: "Paid", type: .payment),
        Tag(id: 2, name: "Remote", type: .location),
        Tag(id: 3, name: "Developer", type: .field)
    ]
    
}
