//
//  Date+Extension.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//
import Foundation

extension Date {
    
    func toStringFormatted(format: String) -> String? {
        let dateformat = DateFormatter()
       dateformat.dateFormat = format
       dateformat.timeZone = NSTimeZone.local
       return dateformat.string(from: self)
    }

}

