//
//  MainView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI

struct MainView: View {
    @State private var seachText: String = ""
    @State var isPushed = false
    
    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                
                HStack(alignment: .center, spacing: 16) {
                    TextField("Input Location Name", text: $seachText)
                        .padding(.horizontal, 8)
                        .frame(height: 45)
                        .background(Color(UIColor.lightGray.withAlphaComponent(0.2)))
                        .cornerRadius(8)
                        .overlay(alignment: .trailing) {
                            if !seachText.isEmpty {
                                Button(action: {
                                    seachText = ""
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .padding(5)
                                        .foregroundColor(Color.black.opacity(0.5))
                                }
                            }
                        }
                    
                    Button("Search") {
                        viewModel.getCurrentWeatherData(search: seachText)
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 55)
                }
                
                VStack(spacing: 0) {
                    switch viewModel.state {
                    case .loading:
                        WeatherStatusView(status: .loading)
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                    case let .loaded(item):
                        WeatherMainCardView(item: item,
                                            units: viewModel.unitsWeather,
                                            onChangeUnit: { units in
                            viewModel.switchUnitsWeather(units: units)
                        },
                                            onTapDetail: { item in
                            isPushed = true
                        })
                        .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                    default:
                        WeatherStatusView(status: .empty)
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                    }
                }
                .padding(.top, 8)
                
                Spacer()
                
            }
            .padding(.all, 16)
            .navigationTitle("Weather")
            .navigationDestination(isPresented: $isPushed) {
                
                if let currentWeather = self.viewModel.getCurrentWeather(), isPushed {
                    DetailView(viewModel: DetailViewModel(currentWeather: currentWeather,
                                                          currentUnits: self.viewModel.unitsWeather))
                } else {
                    EmptyView()
                }
            }
    
        }
        .onAppear {
            seachText = "Bangkok"
            viewModel.getCurrentWeatherData(search: seachText)
        }
        .onDisappear {
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
