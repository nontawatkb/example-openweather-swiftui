//
//  DetailViewModel.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 24/3/2566 BE.
//

import Combine
import Foundation

public class DetailViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded([WeatherGroupDayItem])
    }
    
    @Published private(set) var state: State = .idle
    
    private let get5DayForecastDataUseCase: Get5DayForecastDataUseCase
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    private let currentWeather: WeatherItem
    private let currentUnits: WeatherRequestUnits
    
    private var list5DayForecastGroup: [WeatherGroupDayItem] = []
    private var list5DayForecast: [WeatherItem]?
    
    @Published var navigationTitle: String
    
    init(currentWeather: WeatherItem,
         currentUnits: WeatherRequestUnits,
         get5DayForecastDataUseCase: Get5DayForecastDataUseCase = Get5DayForecastDataUseCaseImpl()) {
        self.currentWeather = currentWeather
        self.currentUnits = currentUnits
        self.get5DayForecastDataUseCase = get5DayForecastDataUseCase
        self.navigationTitle = self.currentWeather.name ?? ""
    }
    
    deinit {
        debugPrint("🔅 Deinitialized. \(String(describing: self))")
    }
    
    func setState(_ state: State) {
        self.state = state
    }
    
    func get5DayForecastData() {
        self.setState(.idle)
        guard let cityName = self.currentWeather.name, !cityName.isEmpty else { return }
        self.list5DayForecast?.removeAll()
        self.setState(.loading)
        self.get5DayForecastDataUseCase.execute(q: cityName, units: self.currentUnits)
            .sink { _ in
                guard let list5DayForecast = self.list5DayForecast, !list5DayForecast.isEmpty else {
                    self.setState(.idle)
                    return
                }
                self.filterGroupByDay(listItem: list5DayForecast)
            } receiveValue: { resp in
                guard let resp = resp, resp.cod == "200" else {
                    return
                }
                self.list5DayForecast = resp.list
            }
            .store(in: &self.anyCancellable)
    }
    
    func filterGroupByDay(listItem: [WeatherItem]) {
        list5DayForecastGroup.removeAll()
        listItem.sliced(by: [.year, .month, .day], for: \.dtDate).forEach({ item in
            let sortListItem = item.1.sorted(by: {$0.dtDate ?? Date() < $1.dtDate ?? Date()})
            list5DayForecastGroup.append(WeatherGroupDayItem(date: item.0,
                                                              listItem: sortListItem,
                                                              unit: self.currentUnits))
        })
        
        guard !self.list5DayForecastGroup.isEmpty else {
            self.setState(.idle)
            return
        }
        let sort = self.list5DayForecastGroup.sorted(by: {$0.date ?? Date() < $1.date ?? Date()})
        self.setState(.loaded(sort))
    }
}


