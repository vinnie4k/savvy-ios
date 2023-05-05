//
//  Post.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import Foundation

class Post: Codable {
    
    var id: Int
    var position: String
    var description: String
    var organization: String
    var payment: String
    var qualifications: String
    var weeklySchedule: String
    var link: String
    var createDate: String
    var tags: [Tag]
    
    init(id: Int, position: String, description: String, organization: String, payment: String, qualifications: String, weeklySchedule: String, link: String, createDate: String, tags: [Tag]) {
        self.id = id
        self.position = position
        self.description = description
        self.organization = organization
        self.payment = payment
        self.qualifications = qualifications
        self.weeklySchedule = weeklySchedule
        self.link = link
        self.createDate = createDate
        self.tags = tags
    }
    
}
let post1 = Post(
    id: 1,
    position: "General Office & Special Projects",
    description: "General Office Duties, Scanning and organizing documents, Setting up and organizing new work areas and stations, Organization and Process Improvement, Developing fillable forms, Revising documents and forms for clarity, Assisting Planning Staff in organizing meetings and applications",
    organization: "City of Ithaca - Planning & Development",
    payment: "$15.00",
    qualifications: "",
    weeklySchedule: "",
    link: "03/06/2023-05/31/2023",
    createDate: "03/06/2023",
    tags: [
        Tag(label: "FWS", type: "Qualifications"),
        Tag(label: "Paid", type: "Payment")
    ]
)

let post2 = Post(
    id: 2,
    position: "Student Developer",
    description: "Conference and Event Services hosts over 12,000 guests in over 150 conferences during the summer and provides excellent customer service. The Student Developer is responsible for helping to write and test computer programs, including building registration portals, running database reports, and writing custom applications and APIs. The Student Developer position helps the Conference Planners, Student Managers, and Administrative Staff. The Student Developer will work alongside the Department and the Student Service IT teams to maintain and oversee various systems during our summer conference and event business. The Student Developer will also be interlaced with the summer operation, to work as a front desk assistant answering questions and providing concierge support to guests, as well as fulfilling duties for on-call hours during the summer. Employees will receive free on-campus summer housing, $500 summer bucks and free summer laundry.",
    organization: "Conference and Event Services",
    payment: "$16.50",
    qualifications: "",
    weeklySchedule: "",
    link: "01/05/2023-05/31/2023",
    createDate: "01/05/2023",
    tags: [
        Tag(label: "Computer Science", type: "Field"),
        Tag(label: "Paid", type: "Payment")
    ]
)

let post3 = Post(
    id: 3,
    position: "Student Research Assistant",
    description: "The Student Research Assistant will conduct phone interviews for a project sponsored by the New York State Department of Environmental Conservation. The Student Research Assistant will conduct nonrespondent phone interviews, meaning these individuals were sent a survey but did not respond, with licensed New York State hunters about their hunting activities over the past year. The Student Research Assistant will follow a script to conduct phone interviews, enter data in Qualtrics software, and track calls in a shared database.",
    organization: "Center for Conservation Social Sciences",
    payment: "$15.95",
    qualifications: "",
    weeklySchedule: "",
    link: "05/12/2023-06/30/2023",
    createDate: "05/12/2023",
    tags: [
        Tag(label: "Art", type: "Field"),
        Tag(label: "Paid", type: "Payment")
    ]
)

let post4 = Post(
    id: 4,
    position: "Molecular Biology Intern",
    description: "We are seeking a fulltime summer intern to help us with molecular biology assays, specifically molecularly labeling DNA and preparing DNA for sequencing. An overview of the project is below. The intern will work with our biomedical engineer to create labels, attach them to DNA, amplify products, characterize the results via gel electrophoresis and spectroscopic techniques, prepare DNA for sequencing, and, depending on their skillset, aid in the analysis of the resulting sequencing data. It will be an 11-week summer internship paying $22.70/hr, with a 40 hour work week.",
    organization: "Esper Biosciences Inc",
    payment: "$22.70",
    qualifications: "",
    weeklySchedule: "",
    link: "05/22/2023-08/04/2023",
    createDate: "05/22/2023",
    tags: [
        Tag(label: "Internship", type: "Qualifications"),
        Tag(label: "Paid", type: "Payment")
    ]
)

let posts = [post1, post2, post3, post4]

let currentPosts = [post1, post4]
let appliedPosts = [post3]
