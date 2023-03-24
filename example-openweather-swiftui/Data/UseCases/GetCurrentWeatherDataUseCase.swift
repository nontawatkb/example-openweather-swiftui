//
//  GetCurrentWeatherDataUseCase.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Combine
import Foundation
import Moya

protocol GetCurrentWeatherDataUseCase {
    func execute(q: String, units: WeatherRequestUnits) -> AnyPublisher<WeatherItem?, MoyaError>
}

class GetCurrentWeatherDataUseCaseImpl: GetCurrentWeatherDataUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(q: String, units: WeatherRequestUnits) -> AnyPublisher<WeatherItem?, MoyaError>{
        let request = WeatherRequest(q: "\(q),th", units: units.rawValue)
        return repository.getCurrentWeatherData(request: request)
    }
}

