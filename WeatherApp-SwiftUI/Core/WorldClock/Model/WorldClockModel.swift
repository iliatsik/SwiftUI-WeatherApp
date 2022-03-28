//
//  WeatherModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import Foundation

struct WorldClock: Decodable, Hashable{
    let name: String
    let capital: String?
    let region: String?
    let timezones: [String]?
}

struct WorldClockModel {
    
    private let worldClock: WorldClock
    
    init(worldClock: WorldClock, id: Int) {
        self.worldClock = worldClock
        self.id = id
    }
    
    var isFavourite = false
    
    var id: Int
 
    var name: String {
        return worldClock.name
    }
    
    var capital: String {
        guard let countryCapital = worldClock.capital else { return "" }
        return countryCapital
    }
    
    var region: String {
        guard let countryRegion = worldClock.capital else { return "" }
        return countryRegion
    }
    
    var exactTime: String {
        
        let initTz = TimeZone(abbreviation: "GMT+4")!
        let targetTz = TimeZone(abbreviation: worldClock.timezones?[0] ?? "UTC+00:00")!
        let initDate = Date()
        
        var calendar = Calendar.current
        calendar.timeZone = initTz
        let case1TargetDate = calendar.dateBySetting(timeZone: targetTz, of: initDate)!
        let case2TargetDate = calendar.dateBySettingTimeFrom(timeZone: targetTz, of: initDate)!

        let formatter = ISO8601DateFormatter()

        formatter.formatOptions = [ .withFullTime ]
               
        formatter.timeZone = initTz

        let index = formatter.string(from: case2TargetDate).index(formatter.string(from: case1TargetDate).startIndex, offsetBy: 5)

        let timeZone =  String(formatter.string(from: case2TargetDate).prefix(upTo: index))
    
        return timeZone
    }
    
    var timeZone: String {
        guard let timeZone = worldClock.timezones else { return "" }
        return timeZone[0]
    }
}
