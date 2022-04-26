//
//  NetworkService.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import Foundation
import Combine

class NetworkService {
    
    func fetch<T: Decodable>(with url: String) -> AnyPublisher<[T], Error> {
        
        let url = URL(string: url)
            
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type:  [T].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
