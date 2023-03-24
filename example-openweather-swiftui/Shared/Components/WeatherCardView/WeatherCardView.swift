//
//  WeatherCardView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI
import Kingfisher

struct WeatherCardView: View {
    
    private let item: WeatherItem
    private let units: WeatherRequestUnits
    
    init(item: WeatherItem, units: WeatherRequestUnits) {
        self.item = item
        self.units = units
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let iconPath = item.weather?.first?.icon, !iconPath.isEmpty {
                    VStack(spacing: 0) {
                        KFImage(URL(string: "https://openweathermap.org/img/wn/\(iconPath)@2x.png")!)
                            .frame(width: 100, height: 100)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    if let temp = item.main?.temp?.stringRounded() {
                        Text("\(temp) \(units.unit)")
                             .font(.title)
                    } else {
                        Text("Error \(units.unit)")
                             .font(.title)
                    }
                    
                    Text("Humidity: \(item.main?.humidity ?? 0)%")
                        .font(.caption)
                }
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
        .background(Color.white)
        .cornerRadius(5)
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
    }

}

