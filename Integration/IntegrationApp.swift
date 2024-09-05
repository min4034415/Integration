//
//  IntegrationApp.swift
//  Integration
//
//  Created by Ouimin Lee on 9/4/24.
//

import SwiftUI
import SwiftData
import MapKit

@main
struct IntegrationApp: App {
        var body: some Scene {
            WindowGroup {
                LocationView()
                    .modelContainer(for: Location.self)
            }
        }
    }
