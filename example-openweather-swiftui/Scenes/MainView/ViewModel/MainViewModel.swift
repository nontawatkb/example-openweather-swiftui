//
//  MainViewModel.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import Combine

public class MainViewModel: ObservableObject {
    
    private let getCoordinatesByLocationNameUseCase: GetCoordinatesByLocationNameUseCase
    private let getCurrentWeatherDataUseCase: GetCurrentWeatherDataUseCase
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    enum State {
        case idle
        case loading
        case searchLoaded([WeatherItem])
        case currentLoaded(WeatherItem, WeatherRequestUnits)
    }
    
    @Published private(set) var stateSearch: State = .idle
    @Published private(set) var stateCurrent: State = .idle
    
    private var listSearchLocation: [WeatherItem]?
    private var currentLocation: WeatherItem?
    private var unitsWeather: WeatherRequestUnits = .fahrenheit

    init(getCoordinatesByLocationNameUseCase: GetCoordinatesByLocationNameUseCase = GetCoordinatesByLocationNameUseCaseImpl(),
         getCurrentWeatherDataUseCase: GetCurrentWeatherDataUseCase = GetCurrentWeatherDataUseCaseImpl()) {
        self.getCoordinatesByLocationNameUseCase = getCoordinatesByLocationNameUseCase
        self.getCurrentWeatherDataUseCase = getCurrentWeatherDataUseCase
    }
    
    func setStateSearch(_ state: State) {
        self.stateSearch = state
    }
    
    func setUnitsWeather(units: WeatherRequestUnits) {
        self.unitsWeather = units
    }
    
    func getCoordinatesByLocation(search: String) {
        self.listSearchLocation?.removeAll()
        guard !search.isEmpty else { return }
        self.setStateSearch(.loading)
        self.getCoordinatesByLocationNameUseCase.execute(q: search)
            .sink { _ in
                guard let listSearchLocation = self.listSearchLocation, !listSearchLocation.isEmpty else {
                    self.setStateSearch(.idle)
                    return
                }
                self.setStateSearch(.searchLoaded(listSearchLocation))
            } receiveValue: { resp in
                self.listSearchLocation = resp
            }
            .store(in: &self.anyCancellable)
    }
    
    func getCurrentWeatherData(lat: Double?, lon: Double?) {
        self.stateCurrent = .idle
        guard let lat = lat, let lon = lon else { return }
        self.stateCurrent = .loading
        self.getCurrentWeatherDataUseCase.execute(lat: lat, lon: lon, units: self.unitsWeather)
            .sink { _ in
                guard let currentLocation = self.currentLocation else {
                    self.stateCurrent = .idle
                    return
                }
                self.stateCurrent = .currentLoaded(currentLocation, self.unitsWeather)
            } receiveValue: { resp in
                self.currentLocation = resp
            }
            .store(in: &self.anyCancellable)
    }
    
    
}

