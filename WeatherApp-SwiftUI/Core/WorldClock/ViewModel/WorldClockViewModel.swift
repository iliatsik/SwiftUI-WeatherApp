//
//  WeatherViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import Foundation
import Combine
import CoreData

final class WorldClockViewModel: ObservableObject  {
    
    @Published var filteredCountryList = [WorldClockModel]()
    @Published var searchText = ""
    var cancellable = Set<AnyCancellable>()
    var countryRepo = CountryRepository()
    
    var countryList: [WorldClockModel] {
        if searchText.isEmpty {
            return filteredCountryList
        } else {
            return filteredCountryList.filter { $0.name.contains(searchText) }
        }
    }
    
    func fetchCountries() {
        countryRepo.fetchCountries { (countryList: [WorldClock]) in
            self.filteredCountryList = countryList.enumerated().map { WorldClockModel(worldClock: $0.element,
                                                                                      id: $0.offset)}
            
            for index in 0..<self.filteredCountryList.count {
                CoreDataManager.shared.getAllSavedCountries().forEach { country in
                    if self.filteredCountryList[index].name == country.name {
                        self.filteredCountryList[index].isFavourite = true
                    }
                }
            }
        }
    }
    
    func countryTapped(with country: WorldClockModel) {
        filteredCountryList[country.id].isFavourite.toggle()
                
        if !filteredCountryList[country.id].isFavourite {
            CoreDataManager.shared.delete(at: country.name)
        } else {
            CoreDataManager.shared.getAllSavedCountries().forEach { savedCountry in
                if savedCountry.name == country.name { return }
            }
            let savedCountry = Country(context: CoreDataManager.shared.viewContext)
            savedCountry.timezone = country.timeZone
            savedCountry.region = country.region
            savedCountry.capital = country.capital
            savedCountry.name = country.name
            savedCountry.identifier = Int64(country.id)
            savedCountry.flagURL = country.flagURL
            savedCountry.population = country.population
        }
        
        CoreDataManager.shared.save()
    }

}
