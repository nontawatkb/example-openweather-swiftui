//
//  WeatherRequest.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Foundation

public enum WeatherRequestUnits: String {
    case fahrenheit = "imperial"
    case celsius = "metric"
    
    var unit: String {
        switch self {
        case .fahrenheit:
            return "°F"
        case .celsius:
            return "°C"
        }
    }
}

public struct WeatherRequest: Codable {
    
    public var q: String?
    public var limit: Int?
    
    public var lat: Double?
    public var lon: Double?
    public var appid: String = "76153cfc50d143f074eab2ead7188c5f" //  AppId is Constant
    public var units: String?
    
    public init() {}
    
    // For getCoordinatesByLocationName
    public init(q: String? = nil, limit: Int? = nil, lat: Double? = nil, lon: Double? = nil, units: String? = nil) {
        self.q = q
        self.limit = limit
        self.lat = lat
        self.lon = lon
        self.units = units
    }
    
    
    enum CodingKeys: String, CodingKey {
        case q = "q"
        case limit = "limit"
        case appid = "appid"
        case lat = "lat"
        case lon = "lon"
        case units = "units"
    }
}
