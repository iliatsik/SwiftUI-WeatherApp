//
//  CountryRepository.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 19.04.22.
//

import Foundation
import Combine

class CountryRepository {
    
    private let networkService = NetworkService()
    private var cancellable = Set<AnyCancellable>()

    func fetchCountries<T: Decodable>(completion: @escaping ([T]) -> Void) {
        networkService.fetch(with: ApiEndpoints.countryURL).sink { _ in
        } receiveValue: { countries in
            completion(countries)
        }.store(in: &cancellable)
    }
}
