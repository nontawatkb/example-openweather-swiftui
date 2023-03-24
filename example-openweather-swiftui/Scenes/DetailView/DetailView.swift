//
//  DetailView.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI

struct DetailView: View {

    @StateObject var viewModel: DetailViewModel

    var body: some View {
        VStack {
            switch self.viewModel.state {
            case .loading:
                ProgressView()
                    .padding(.all, 20)
            case .idle:
                EmptyView()
            case let .loaded(items):
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 3) {
                        ForEach(items, id: \.self) { item in
                            WeatherDayCardView(itemGroup: item)
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            self.viewModel.get5DayForecastData()
        }
        .onDisappear {
        }
    }
}
