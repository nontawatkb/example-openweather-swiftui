//
//  WeatherStatusView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//

import SwiftUI
import Kingfisher

enum WeatherStatusType {
    case loading
    case empty
}

struct WeatherStatusView: View {
    
    let status: WeatherStatusType
    
    init(status: WeatherStatusType) {
        self.status = status
    }
    
    var body: some View {
        VStack(alignment: .center) {
            switch status {
            case .loading:
                ProgressView()
            case .empty:
                Text("data not found")
                    .foregroundColor(Color(UIColor.darkGray))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
        .frame(height: 150)
        .background(Color.white)
        .cornerRadius(8)
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
    }

}
