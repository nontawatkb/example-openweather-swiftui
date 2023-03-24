//
//  WeatherRepository.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Combine
import Moya


protocol WeatherRepository {
    func getCurrentWeatherData(request: WeatherRequest) -> AnyPublisher<WeatherItem?, MoyaError>
    func get5DayForecastData(request: WeatherRequest) -> AnyPublisher<WeatherResponse?, MoyaError>
}

final class WeatherRepositoryImpl: WeatherRepository {
    
    private let provider: MoyaProvider<WeatherAPI> = MoyaProvider<WeatherAPI>()

    func getCurrentWeatherData(request: WeatherRequest) -> AnyPublisher<WeatherItem?, MoyaError> {
        return self.provider.requestPublisher(.getCurrentWeatherData(request: request))
            .map(WeatherItem?.self)
    }
    
    func get5DayForecastData(request: WeatherRequest) -> AnyPublisher<WeatherResponse?, MoyaError> {
        return self.provider.requestPublisher(.get5DayForecastData(request: request))
            .map(WeatherResponse?.self)    }
    
}
