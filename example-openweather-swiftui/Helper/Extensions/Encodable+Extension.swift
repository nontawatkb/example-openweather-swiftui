//
//  Encodable+Extension.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Foundation

extension Encodable {
    
    public func toJSON() -> [String: Any] {
        do {
            let encoded = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

