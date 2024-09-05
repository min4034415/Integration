//
//  Location.swift
//  Integration
//
//  Created by Ouimin Lee on 9/4/24.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class Location {
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    init(location: CLLocationCoordinate2D) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
}

