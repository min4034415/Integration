import SwiftUI
import SwiftData
import CoreLocation
import MapKit

struct SuperNovaView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var locations: [Location]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(locations) { location in
                    NavigationLink {
                        Text("Location at \(location.latitude), \(location.longitude)")
                        Map{
                            Marker("\(location.latitude)", coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                            )
                        }
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
                    Button(action: addLocation) {
                        Label("Add Location", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a location")
        }
    }

    private func addLocation() {
        withAnimation {
            // You can replace the coordinates with any default or random values
//            let newLocation = Location(latitude: 37.7749, longitude: -122.4194) // Example coordinates
            let newLocation = Location(latitude: 48.8580, longitude: 2.2946) // Example coordinates
            modelContext.insert(newLocation)
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
    SuperNovaView()
        .modelContainer(for: Location.self, inMemory: true)
}
