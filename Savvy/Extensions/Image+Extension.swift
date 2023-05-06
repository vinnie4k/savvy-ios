//
//  Image+Extension.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI

extension Image {
    
    static let savvy = Savvy()
    
    struct Savvy {
        let backArrow = Image(systemName: "arrow.left")
        let bookmark = Image(systemName: "bookmark")
        let bookmarkFill = Image(systemName: "bookmark.fill")
        let cross = Image("cross")
        let googleLogo = Image("google-logo")
        let magnifyingGlass = Image(systemName: "magnifyingglass")
    }
    
}
