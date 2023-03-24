//
//  example_openweather_swiftuiApp.swift
//  example-openweather-swiftui
//
//  Created by Nontawat Kanboon on 23/3/2566 BE.
//

import SwiftUI

@main
struct example_openweather_swiftuiApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
                .preferredColorScheme(.light)
//            TestView()
        }
    }
}

import SwiftUI

struct TestView: View {
    
    var body: some View {
        VStack {
            Text("HELLO WORLD")
        }
    }
}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
