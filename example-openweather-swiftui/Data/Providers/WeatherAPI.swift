//
//  WeatherAPI.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Foundation
import Moya

public enum WeatherAPI {
    case getCoordinatesByLocationName(request: WeatherRequest)
    case getCurrentWeatherData(request: WeatherRequest)
    case get5DayForecastData(request: WeatherRequest)
}

extension WeatherAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }
    
    public var path: String {
        switch self {
        case .getCoordinatesByLocationName:
            return "/geo/1.0/direct"
        case .getCurrentWeatherData:
            return "/data/2.5/weather"
        case .get5DayForecastData:
            return "/data/2.5/forecast"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Moya.Task {
        switch self {
        case let .getCoordinatesByLocationName(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.default)
        case let .getCurrentWeatherData(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.default)
        case let .get5DayForecastData(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}
