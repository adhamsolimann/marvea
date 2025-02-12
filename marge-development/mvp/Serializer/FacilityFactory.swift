//
//  FacilityFactory.swift
//  mvp
//
//  Created by adham soliman on 03.02.23.
//

    import Foundation

    final class FaciltityFactory {
        
        static func build() -> [FacilityObject] {
            do {
                guard let path = Bundle.main.path(forResource: "Gesamte-Anlagen-Export", ofType: "json") else {
                    throw FactoryError.fileNotFound
                }
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let locations = try JSONDecoder().decode([FacilityObject].self, from: data)
                return locations
            } catch {
                print("Error creating facility objects: \(error)")
                return []
            }
        }
    }

    enum FactoryError: Error {
        case fileNotFound
    }
