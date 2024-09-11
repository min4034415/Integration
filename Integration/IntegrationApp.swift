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
            TabView{
                LocationView()
                    .modelContainer(for: Location.self)
                    .tabItem {
                        Label("Trash", systemImage: "trash.fill")
                            .foregroundColor(.yellow)
                    }
                SuperNovaView()
                    .modelContainer(for: Location.self)
                    .tabItem {
                        Label("Learn", systemImage: "star.fill")
                            .foregroundColor(.gray) // Color change on selection
                    }
                AespaView()
                    .modelContainer(for: Location.self)
                    .tabItem {
                        Label("Learn", systemImage: "pencil.circle.fill")
                            .foregroundColor(.gray) // Color change on selection
                    }
            }
        }
    }
}
