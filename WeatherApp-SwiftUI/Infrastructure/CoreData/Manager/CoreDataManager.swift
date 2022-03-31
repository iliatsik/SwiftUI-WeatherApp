//
//  CoreDataManager.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 29.03.22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Country")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error: \(error)")
            } 
        }
    }

    func getAllSavedCountries() -> [Country] {
        let request: NSFetchRequest<Country>  = Country.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("error ")
        }
    }
    
    func delete(at name: String) {
        getAllSavedCountries().forEach { savedCountry in
            if savedCountry.name == name {
                viewContext.delete(savedCountry)
            }
        }
    }
}
