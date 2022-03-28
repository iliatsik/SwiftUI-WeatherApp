//
//  DateFormatter.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 25.03.22.
//

import Foundation

extension Calendar {

    func dateBySetting(timeZone: TimeZone, of date: Date) -> Date? {
        var components = dateComponents(in: self.timeZone, from: date)
        components.timeZone = timeZone
        return self.date(from: components)
    }

    func dateBySettingTimeFrom(timeZone: TimeZone, of date: Date) -> Date? {
        var components = dateComponents(in: timeZone, from: date)
        components.timeZone = self.timeZone
        return self.date(from: components)
    }
}

