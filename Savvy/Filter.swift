//
//  Filter.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import Foundation
import UIKit
class Filter {
    var filterLabel: String
    var isSelected: Bool
    
    init (label: String) {
        self.filterLabel = label
        self.isSelected = false
    }
}

let filters = [Filter(label: "CS"), Filter(label: "FWS"), Filter(label: "Internship"), Filter(label: "Biology"), Filter(label: "Research"), Filter(label: "Social Science")]
