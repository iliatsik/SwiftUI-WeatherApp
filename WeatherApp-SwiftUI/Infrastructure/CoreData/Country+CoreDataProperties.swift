//
//  Country+CoreDataProperties.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 28.03.22.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var capital: String?
    @NSManaged public var name: String?
    @NSManaged public var population: Int32
    @NSManaged public var region: String?
    @NSManaged public var timezone: String?

}

extension Country : Identifiable {

}
