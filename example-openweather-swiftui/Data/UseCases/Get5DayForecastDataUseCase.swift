//
//  Get5DayForecastDataUseCase.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Combine
import Foundation
import Moya

protocol Get5DayForecastDataUseCase {
    func execute(lat: Double?, lon: Double?) -> AnyPublisher<WeatherResponse?, MoyaError>
}

class Get5DayForecastDataUseCaseImpl: Get5DayForecastDataUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(lat: Double?, lon: Double?) -> AnyPublisher<WeatherResponse?, MoyaError>{
        let request = WeatherRequest(lat: lat, lon: lon)
        return repository.get5DayForecastData(request: request)
    }
}

