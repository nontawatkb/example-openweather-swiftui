//
//  MainViewModel.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Combine
import SwiftUI

public class MainViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded(WeatherItem)
    }
    
    @Published private(set) var state: State = .idle
    
    private let getCurrentWeatherDataUseCase: GetCurrentWeatherDataUseCase
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    private var currentWeather: WeatherItem?
    var unitsWeather: WeatherRequestUnits = .celsius
    
    init(getCurrentWeatherDataUseCase: GetCurrentWeatherDataUseCase = GetCurrentWeatherDataUseCaseImpl()) {
        self.getCurrentWeatherDataUseCase = getCurrentWeatherDataUseCase
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
    }
    
    func setState(_ state: State) {
        self.state = state
    }
    
    func switchUnitsWeather(units: WeatherRequestUnits) {
        self.unitsWeather = units
        self.getCurrentWeatherData(search: self.currentWeather?.name)
    }
    
    func getCurrentWeatherData(search: String?) {
        self.setState(.idle)
        guard let search = search, !search.isEmpty else { return }
        self.currentWeather = nil
        self.setState(.loading)
        self.getCurrentWeatherDataUseCase.execute(q: search, units: self.unitsWeather)
            .sink { _ in
                guard let currentWeather = self.currentWeather else {
                    self.setState(.idle)
                    return
                }
                self.setState(.loaded(currentWeather))
            } receiveValue: { resp in
                guard let resp = resp, resp.cod == 200 else {
                    return
                }
                self.currentWeather = resp
            }
            .store(in: &self.anyCancellable)
    }
    
    func getCurrentWeather() -> WeatherItem? {
        return self.currentWeather
    }
    
}

