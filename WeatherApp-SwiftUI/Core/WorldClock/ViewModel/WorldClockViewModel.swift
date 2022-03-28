//
//  WeatherViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import Foundation
import Combine

final class WorldClockViewModel: ObservableObject  {
    
    private let networkService = NetworkService()
    
    @Published var countries = [WorldClockModel]()
    @Published var searchText = ""
    var allCountries = [WorldClockModel]()
    
    
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
            self.countries = countryList.enumerated().map { WorldClockModel(worldClock: $0.element,
                                                                            id: $0.offset)}
        })
            .store(in: &cancellable)
    }
    
    func countryTapped(with id: Int) {
        countries[id].isFavourite.toggle()
        //core data davaupdateo da tavidan davfetcho
    }
    
    func getCountries() -> AnyPublisher<[WorldClockModel], Never> {
        $countries.compactMap { [weak self] in
            guard let self = self else { return nil}
            return $0.filter { $0.name.contains(self.searchText) }
        }.eraseToAnyPublisher()
    }
}
