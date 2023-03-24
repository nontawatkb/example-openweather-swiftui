//
//  WeatherTimeCardView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//

import SwiftUI
import Kingfisher

struct WeatherTimeCardView: View {
    
    private let item: WeatherItem
    private let unit: WeatherRequestUnits
    
    init(item: WeatherItem, unit: WeatherRequestUnits) {
        self.item = item
        self.unit = unit
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 0) {
                
                if let date = item.dtDate {
                    Text(date.toStringFormatted(format: "HH:mm") ?? "")
                        .foregroundColor(Color(UIColor.darkText))
                        .font(Font.system(size: 14))
                }
                
                if let iconPath = item.weather?.first?.icon, !iconPath.isEmpty {
                    KFImage(URL(string: "https://openweathermap.org/img/wn/\(iconPath)@2x.png")!)
                        .frame(width: 120, height: 80)
                }
                
                Text("\(item.main?.temp?.stringRounded() ?? "Error") \(unit.unit)")
                    .foregroundColor(Color(UIColor.darkText))
                    .font(Font.system(size: 14))
            }
            .padding(.vertical, 8)
        }
        .frame(width: 120)
        .background(Color.white)
        .cornerRadius(5)// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        //        .clipped()
        //        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
    }
    
}


