//
//  CountryViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 29.03.22.
//

import Foundation

class CountryViewModel: ObservableObject {

    @Published var countries: [Country] = []
    
    func getAllCountries() {
        countries = CoreDataManager.shared.getAllSavedCountries()
    }
    
}
