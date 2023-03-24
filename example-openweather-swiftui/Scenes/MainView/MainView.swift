//
//  MainView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI

struct MainView: View {
    @State private var showingSheet = false
    @State private var seachText: String = ""
    
    @ObservedObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 16) {
                    TextField("Input Location Name", text: $seachText)
                        .onChange(of: seachText) {
                            if $0.isEmpty {
                                viewModel.setStateSearch(.idle)
                            }
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 45)
                        .background(Color(UIColor.lightGray.withAlphaComponent(0.2)))
                        .cornerRadius(5)
                        .overlay(alignment: .trailing) {
                            if !seachText.isEmpty {
                                Button(action: {
                                    seachText = ""
                                    viewModel.setStateSearch(.idle)
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .padding(5)
                                        .foregroundColor(Color.black.opacity(0.5))
                                }
                            }
                        }
                    
                    Button("Search") {
                        viewModel.getCoordinatesByLocation(search: seachText)
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 55)
                }
                
                HStack(alignment: .center, spacing: 16) {
                    VStack {
                        Spacer()
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .top
                    )
                    .overlay(alignment: .top) {
                        VStack(alignment: .leading) {
                            switch viewModel.stateSearch {
                            case .loading:
                                ProgressView()
                                    .padding(.vertical, 16)
                            case let .searchLoaded(results):
                                VStack(spacing: 0) {
                                    ForEach(results, id: \.self) { item in
                                        SearchItemView(item: item)
                                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                                            .overlay(alignment: .bottom) {
                                                Spacer()
                                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 1.0, maxHeight: 1.0,alignment: .top)
                                                    .background(Color(UIColor.lightGray.withAlphaComponent(0.25)))
                                            }
                                            .background(Color.white)
                                            .onTapGesture {
                                                seachText = ""
                                                viewModel.setStateSearch(.idle)
                                                viewModel.getCurrentWeatherData(lat: item.lat, lon: item.lon)
                                            }
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                                .padding(.all, 8)
                            default:
                                EmptyView()
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                        .background(Color.white)
                        .cornerRadius(5)
                        .clipped()
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
                        .padding(.top, 8)
                    }
                    
                    
                    Spacer()
                        .frame(width: 55)
                }
                .zIndex(5)
                .frame(height: 0)
                
                VStack(spacing: 0) {
                    switch viewModel.stateCurrent {
                    case .loading:
                        ProgressView()
                            .padding(.vertical, 16)
                    case let .currentLoaded(item, units):
                        WeatherCardView(item: item, units: units)
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .top)
                            .padding(.top, 8)
                    default:
                        EmptyView()
                    }
                }
                .zIndex(1)
                
                Spacer()
            }
            .padding(.all, 16)
            .navigationTitle("Weather Page")
        }
        .onAppear {
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
