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
    func execute(q: String, units: WeatherRequestUnits) -> AnyPublisher<WeatherResponse?, MoyaError>
}

class Get5DayForecastDataUseCaseImpl: Get5DayForecastDataUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(q: String, units: WeatherRequestUnits) -> AnyPublisher<WeatherResponse?, MoyaError>{
        let request = WeatherRequest(q: "\(q),th", units: units.rawValue)
        return repository.get5DayForecastData(request: request)
    }
}

