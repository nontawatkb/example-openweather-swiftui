//
//  String+Extension.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//

import Foundation
extension String {
    func convertToDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = Foundation.DateFormatter()
        formatter.locale = .current
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
