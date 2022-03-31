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
    
    private let networkService = NetworkService()
    @Published var filteredCountryList = [WorldClockModel]()
    @Published var searchText = ""

    var countryList: [WorldClockModel] {
        if searchText.isEmpty {
            return filteredCountryList
        } else {
            return filteredCountryList.filter { $0.name.contains(searchText) }
        }
    }
    
    var cancellable = Set<AnyCancellable>()
    
    func fetchCountries() {
        networkService.fetchCountries().sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("Finished")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { countryList in
            self.filteredCountryList = countryList.enumerated().map { WorldClockModel(worldClock: $0.element,
                                                                            id: $0.offset)}
            
            for index in 0..<self.filteredCountryList.count {
                CoreDataManager.shared.getAllSavedCountries().forEach { country in
                    if self.filteredCountryList[index].name == country.name {
                        self.filteredCountryList[index].isFavourite = true
                    }
                }
            }
        })
            .store(in: &cancellable)
    }
    
    func countryTapped(with country: WorldClockModel) {
        filteredCountryList[country.id].isFavourite.toggle()
        
        let savedCountry = Country(context: CoreDataManager.shared.viewContext)
        
        if !filteredCountryList[country.id].isFavourite {
            CoreDataManager.shared.delete(country: savedCountry)
        } else {
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
