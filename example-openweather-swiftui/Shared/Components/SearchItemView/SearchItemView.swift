//
//  SearchItemView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI

struct SearchItemView: View {
    
    private let item: WeatherItem
    
    init(item: WeatherItem) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.item.name ?? "")
                    .font(.caption)
                Spacer()
                Text(self.item.state ?? "")
                    .font(.caption2)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
}
