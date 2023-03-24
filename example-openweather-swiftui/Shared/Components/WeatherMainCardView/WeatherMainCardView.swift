//
//  WeatherMainCardView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI
import Kingfisher

struct WeatherMainCardView: View {
    
    private let item: WeatherItem
    private let units: WeatherRequestUnits
    private let onChangeUnit: ((WeatherRequestUnits) -> Void)
    private let onTapDetail: ((WeatherItem) -> Void)
    
    init(item: WeatherItem,
         units: WeatherRequestUnits,
         onChangeUnit: @escaping ((WeatherRequestUnits) -> Void),
         onTapDetail: @escaping ((WeatherItem) -> Void)) {
        self.item = item
        self.units = units
        self.onChangeUnit = onChangeUnit
        self.onTapDetail = onTapDetail
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
        
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(item.name ?? "")")
                        .font(.system(size: 18))
                    
                    HStack {
                        Text("\(item.main?.temp?.stringRounded() ?? "Error")")
                            .font(.system(size: 36))
                        HStack(spacing: 8) {
                            Text("\(units.unit)")
                                .font(.system(size: 36))
                            
                            HStack {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(Color(UIColor.gray))
                                
                                Text("\(units == .celsius ? WeatherRequestUnits.fahrenheit.unit : WeatherRequestUnits.celsius.unit)")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(UIColor.darkGray))
                                    
                            }
                            .onTapGesture {
                                let newUnit: WeatherRequestUnits = self.units == .celsius ? .fahrenheit : .celsius
                                onChangeUnit(newUnit)
                            }
                        }
                    }
                    
                    Text("Humidity: \(item.main?.humidity ?? 0)%")
                        .font(.system(size: 12))
                }
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 25, height: 50)
                    .foregroundColor(Color(UIColor.gray))
                    .onTapGesture {
                        onTapDetail(item)
                    }
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

