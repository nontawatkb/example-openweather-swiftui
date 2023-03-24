//
//  GetCoordinatesByLocationNameUseCase.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Combine
import Foundation
import Moya

protocol GetCoordinatesByLocationNameUseCase {
    func execute(q: String) -> AnyPublisher<[WeatherItem]?, MoyaError>
}

class GetCoordinatesByLocationNameUseCaseImpl: GetCoordinatesByLocationNameUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository = WeatherRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(q: String) -> AnyPublisher<[WeatherItem]?, MoyaError> {
        let request = WeatherRequest(q: "\(q),,th", limit: 5)
        return repository.getCoordinatesByLocationName(request: request)
    }
}
