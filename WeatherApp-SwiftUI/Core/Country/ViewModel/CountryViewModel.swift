//
//  CountryViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 29.03.22.
//

import Foundation

@MainActor class CountryViewModel: ObservableObject {

    private var messageArrayForCountries = ""
    
    @Published var countries: [Country] = []
    @Published var document: MessageDocument = MessageDocument(message: "")
    @Published var isExporting = false
    
    func getAllCountries() -> [Country] {
        CoreDataManager.shared.getAllSavedCountries()
    }
    
    func configureMessage() {
        isExporting.toggle()

        countries.forEach { country in
            messageArrayForCountries += "Country: \(country.name ?? ""), Capital: \(country.capital ?? ""), Region: \(country.region ?? ""), Population: \(country.population). \n"
        }
        document = MessageDocument(message: messageArrayForCountries)
    }
}
