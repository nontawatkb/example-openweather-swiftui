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
    func execute(lat: Double, lon: Double, units: WeatherRequestUnits) -> AnyPublisher<WeatherItem?, MoyaError>
}

class GetCurrentWeatherDataUseCaseImpl: GetCurrentWeatherDataUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(lat: Double, lon: Double, units: WeatherRequestUnits) -> AnyPublisher<WeatherItem?, MoyaError>{
        let request = WeatherRequest(lat: lat, lon: lon, units: units.rawValue)
        return repository.getCurrentWeatherData(request: request)
    }
}

