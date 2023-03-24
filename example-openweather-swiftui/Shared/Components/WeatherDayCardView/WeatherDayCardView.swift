//
//  WeatherDayCardView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//

import SwiftUI

struct WeatherDayCardView: View {
    
    private let itemGroup: WeatherGroupDayItem
    
    init(itemGroup: WeatherGroupDayItem) {
        self.itemGroup = itemGroup
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            LazyVStack(alignment: .leading, spacing: 8) {
                if let date = itemGroup.date {
                    if Calendar.current.isDateInToday(date) {
                        dateTextView(text: "Today, \(date.toStringFormatted(format: "d MMM") ?? "")")
                    } else {
                        dateTextView(text: date.toStringFormatted(format: "EEE, d MMM") ?? "")
                    }
                }
                
                if let listItem = itemGroup.listItem {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Spacer().frame(width: 8)
                        HStack(spacing: 8) {
                            ForEach(listItem, id: \.self) { item in
                                WeatherTimeCardView(item: item, unit: itemGroup.unit)
                            }
                        }
                        Spacer().frame(width: 8)
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 0)
        .background(Color.white)
        .cornerRadius(5)
    }
    
    func dateTextView(text: String) -> AnyView {
        return AnyView(Text(text)
            .foregroundColor(Color(UIColor.black))
            .font(Font.system(size: 20))
            .fontWeight(.medium)
            .padding(.horizontal, 8))
    }
    
}


