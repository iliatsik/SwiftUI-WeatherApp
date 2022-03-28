//
//  NetworkService.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import Foundation
import Combine

final class NetworkService {

    func fetchCountries() -> AnyPublisher<[WorldClock], Error> {
         
        let url = URL(string: ApiEndpoints.countryURL)

        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type:  [WorldClock].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() 
    }

}
