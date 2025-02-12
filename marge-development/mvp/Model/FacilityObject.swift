//
//  FacilityModel.swift
//  mvp
//
//  Created by adham soliman on 03.02.23.
//

import Foundation
import UIKit

private enum CodingKeys: String, CodingKey {
    case name = "name"
    case address = "adresse"
    case latitude = "pos_lat"
    case longitude = "pos_long"
    case performance = "inst_leistung"
    case launch = "inbetriebnahme"
    case image = "energie_typ"
}

struct FacilityObject {
    let name: String
    let imageName: String?
    let address: String
    let latitude: Double
    let longitude: Double
    let performance: String
    let launch: String?
    

    var image: UIImage? {
        guard let name = imageName else { return nil }
        return UIImage.init(named: name)
    }
}

extension FacilityObject: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.imageName = try container.decode(String?.self, forKey: .image)
        self.address = try container.decode(String.self, forKey: .address)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.performance = try container.decode(String.self, forKey: .performance)
        self.launch = try container.decode(String?.self, forKey: .launch)
    }
}
