//
//  Double+Extension.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//
import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
    func stringRounded() -> String {
        return String(format: "%.0f", self.rounded())
    }
}
