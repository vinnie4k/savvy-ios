//
//  Font+Extension.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import SwiftUI

extension Font {
    
    static func sfPro(size: CGFloat, weight: Weight) -> Font {
        return system(size: size, weight: weight)
    }
    
    static func newYorkRegular(size: CGFloat) -> Font {
        let descriptor = UIFont.systemFont(ofSize: 24, weight: .regular).fontDescriptor
        return Font(UIFont(descriptor: descriptor.withDesign(.serif) ?? descriptor, size: size))
    }
    
    static func newYorkMedium(size: CGFloat) -> Font {
        let descriptor = UIFont.systemFont(ofSize: 24, weight: .medium).fontDescriptor
        return Font(UIFont(descriptor: descriptor.withDesign(.serif) ?? descriptor, size: size))
    }
    
    static func newYorkSemibold(size: CGFloat) -> Font {
        let descriptor = UIFont.systemFont(ofSize: 24, weight: .semibold).fontDescriptor
        return Font(UIFont(descriptor: descriptor.withDesign(.serif) ?? descriptor, size: size))
    }
    
    static func newYorkBold(size: CGFloat) -> Font {
        let descriptor = UIFont.systemFont(ofSize: 24, weight: .bold).fontDescriptor
        return Font(UIFont(descriptor: descriptor.withDesign(.serif) ?? descriptor, size: size))
    }
    
}
