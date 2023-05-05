//
//  Tag.swift
//  Savvy
//
//  Created by Jenny Yu on 5/5/23.
//

import Foundation
import UIKit

class Tag: Codable {
    
    var label: String
    var type: String
    
    init (label: String, type: String) {
        self.label = label
        self.type = type
    }
}

let fieldsTags = [
    Tag(label: "Computer Science", type: "Field" ),
    Tag(label: "Engineering", type: "Field"),
    Tag(label: "Art", type: "Field"),
    Tag(label: "Health", type: "Field"),
    Tag(label: "Agriculture", type: "Field")
]

let locationTags = [
    Tag(label: "Remote", type: "Location"),
    Tag(label: "On-site", type: "Location"),
    Tag(label: "Hybrid", type: "Location")
]

let paymentTags = [
    Tag(label: "Paid", type: "Payment"),
    Tag(label: "Unpaid", type: "Payment"),
    Tag(label: "Academic Credit", type: "Payment")
]
                      
let qualificationsTags = [
    Tag(label: "FWS", type: "Qualifications"),
    Tag(label: "Non FWS", type: "Qualifications"),
    Tag(label: "Internship", type: "Qualifications")
]
