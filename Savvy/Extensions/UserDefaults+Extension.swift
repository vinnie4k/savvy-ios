//
//  UserDefaults+Extension.swift
//  Savvy
//
//  Created by Vin Bui on 5/6/23.
//

import Foundation

extension UserDefaults {
    
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }
    
}
