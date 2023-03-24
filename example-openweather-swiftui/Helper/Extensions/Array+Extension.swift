//
//  Array+Extension.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//

import Foundation

extension Array {
    func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, Date?>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            if let curMath = cur[keyPath: key] {
                let components = Calendar.current.dateComponents(dateComponents, from: curMath)
                let date = Calendar.current.date(from: components)!
                let existing = acc[date] ?? []
                acc[date] = existing + [cur]
            } 
        }
        
        return groupedByDateComponents
    }
}
