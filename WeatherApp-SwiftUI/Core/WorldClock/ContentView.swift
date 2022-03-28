//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        NavigationView {
            List(0..<20){ Index in
            
            }.frame(width: 100, height: 100)
                .background(Color.blue)
            .navigationTitle("Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView()
        }
    }
}
