import SwiftUI
import SwiftData
import CoreLocation

struct AespaView: View {
    @StateObject private var locationManager = LocationManager()
    @Environment(\.modelContext) private var modelContext
    @Query private var locations: [Location]

    var body: some View {
        NavigationSplitView {
            
            if let coordinate = locationManager.lastKnownLocation {
                Text("Latitude: \(coordinate.latitude)")
                
                Text("Longitude: \(coordinate.longitude)")
            } else {
                Text("Unknown Location")
            }
            Button("Get location") {
                locationManager.checkLocationAuthorization()
            }
            .buttonStyle(.borderedProminent)
            
            List {
                ForEach(locations) { location in
                    NavigationLink {
                        Text("Location at \(location.latitude), \(location.longitude)")
                    } label: {
                        Text("Lat: \(location.latitude), Lon: \(location.longitude)")
                    }
                    
                }
                .onDelete(perform: deleteLocations)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addCurrentLocation) {
                        Label("Add Current Location", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a location")
        }
    }

//    private func addLocation() {
//        withAnimation {
//            // You can replace the coordinates with any default or random values
////            let newLocation = Location(latitude: 37.7749, longitude: -122.4194) // Example coordinates
//            let newLocation = Location(latitude: 48.858093, longitude: -2.294694) // Example coordinates
//            modelContext.insert(newLocation)
//        }
//    }

//    private func addCurrentLocation() {
//        withAnimation {
//            if let currentLocation = locationManager.currentLocation {
//                // Create a new Location using the current coordinates
//                let newLocation = Location(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
//                modelContext.insert(newLocation)
//            }
//        }
//    }
    
    private func addCurrentLocation() {
        withAnimation {
            if let currentLocation = locationManager.lastKnownLocation {
                // Create a new Location using the current coordinates
                let newLocation = Location(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                modelContext.insert(newLocation)
            }
        }
    }
    
    private func deleteLocations(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(locations[index])
            }
        }
    }
}

#Preview {
    AespaView()
        .modelContainer(for: Location.self, inMemory: true)
}
