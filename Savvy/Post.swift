//
//  Post.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import Foundation
class Post: Codable {
    var id: Int
    var jobId: String
    var positionName: String
    var employer: String
    var recruiter: String
    var description: String
    var numPositionAvailable: Int
    var duration: String
    var wage: String
    var type: String
    
    init(id: Int, jobId: String, positionName: String, employer: String, recruiter: String, description: String, numPositionAvailable: Int, duration: String, wage: String, type: String) {
        self.id = id
        self.jobId = jobId
        self.positionName = positionName
        self.employer = employer
        self.recruiter = recruiter
        self.description = description
        self.numPositionAvailable = numPositionAvailable
        self.duration = duration
        self.wage = wage
        self.type = type
    }
    
}
let post1 = Post(id: 1, jobId: "65215", positionName: "General Office & Special Projects", employer: "City of Ithaca - Planning & Development", recruiter: "Lisa Nicholas", description: "General Office Duties, Scanning and organizing documents, Setting up and organizing new work areas and stations, Organization and Process Improvement, Developing fillable forms, Revising documents and forms for clarity, Assisting Planning Staff in organizing meetings and applications", numPositionAvailable: 2, duration: "03/06/2023-05/31/2023", wage: "15.00", type: "FWS | Community")
let post2 = Post(id: 2, jobId: "65340", positionName: "Student Developer", employer: "Conference and Event Services", recruiter: "Stefanie Bennett", description: "Conference and Event Services hosts over 12,000 guests in over 150 conferences during the summer and provides excellent customer service. The Student Developer is responsible for helping to write and test computer programs, including building registration portals, running database reports, and writing custom applications and APIs. The Student Developer position helps the Conference Planners, Student Managers, and Administrative Staff. The Student Developer will work alongside the Department and the Student Service IT teams to maintain and oversee various systems during our summer conference and event business. The Student Developer will also be interlaced with the summer operation, to work as a front desk assistant answering questions and providing concierge support to guests, as well as fulfilling duties for on-call hours during the summer. Employees will receive free on-campus summer housing, $500 summer bucks and free summer laundry.", numPositionAvailable: 2, duration: "01/05/2023-05/31/2023", wage: "16.50", type: "CS")
let post3 = Post(id: 3, jobId: "65652", positionName: "Student Research Assistant", employer: "Center for Conservation Social Sciences", recruiter: "Katie Walsh", description: "The Student Research Assistant will conduct phone interviews for a project sponsored by the New York State Department of Environmental Conservation. The Student Research Assistant will conduct nonrespondent phone interviews, meaning these individuals were sent a survey but did not respond, with licensed New York State hunters about their hunting activities over the past year. The Student Research Assistant will follow a script to conduct phone interviews, enter data in Qualtrics software, and track calls in a shared database.", numPositionAvailable: 2, duration: "05/12/2023-06/30/2023", wage: "15.95", type: "Research | Social Science")
let post4 = Post(id: 4, jobId: "65649", positionName: "Molecular biology intern", employer: "Esper Biosciences Inc", recruiter: "Dr. Jonathan Alden", description: "We are seeking a fulltime summer intern to help us with molecular biology assays, specifically molecularly labeling DNA and preparing DNA for sequencing. An overview of the project is below. The intern will work with our biomedical engineer to create labels, attach them to DNA, amplify products, characterize the results via gel electrophoresis and spectroscopic techniques, prepare DNA for sequencing, and, depending on their skillset, aid in the analysis of the resulting sequencing data. It will be an 11-week summer internship paying $22.70/hr, with a 40 hour work week.", numPositionAvailable: 1, duration: "05/22/2023-08/04/2023", wage: "22.70", type: "Internship | Biology")
let posts = [post1, post2, post3, post4]
