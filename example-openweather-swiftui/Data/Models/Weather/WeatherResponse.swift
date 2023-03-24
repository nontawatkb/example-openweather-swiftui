//
//  WeatherResponse.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Foundation

public struct WeatherResponse: Codable, Hashable {
    
    public var cod: String?
    public var message: Int?
    public var list: [WeatherItem]?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case list = "list"
    }
}
    

public struct WeatherItem: Codable, Hashable {
    
    public var cod: Int?
    public var name: String?
    public var lat: Double?
    public var lon: Double?
    public var country: String?
    public var state: String?
    
    public var id: Int?
    public var timezone: Int?
    public var weather: [WeatherItemWeather]?
    public var main: WeatherItemMain?
    public var wind: WeatherItemWind?
    
    public var dtTxt: String?
    public var dtDate: Date? {
        return dtTxt?.convertToDate()
    }
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case name = "name"
        case lat = "lat"
        case lon = "lon"
        case country = "country"
        case state = "state"
        case id = "id"
        case timezone = "timezone"
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case dtTxt = "dt_txt"
    }
}

public struct WeatherItemWeather: Codable, Hashable {
    
    public var id: Int?
    public var main: String?
    public var description: String?
    public var icon: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

public struct WeatherItemMain: Codable, Hashable {
    
    public var temp: Double?
    public var feelsLike: Double?
    public var tempMin: Double?
    public var tempMax: Double?
    public var pressure: Int?
    public var humidity: Int?
    public var seaLevel: Int?
    public var grndLevel: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

public struct WeatherItemWind: Codable, Hashable {
    
    public var speed: Double?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
    }
}

public struct WeatherGroupDayItem: Hashable {
    
    public let date: Date?
    public let listItem: [WeatherItem]?
    public let unit: WeatherRequestUnits
    
    init(date: Date?, listItem: [WeatherItem]?, unit: WeatherRequestUnits) {
        self.date = date
        self.listItem = listItem
        self.unit = unit
    }
    
}
