//
//  ContentView.swift
//  Integration
//
//  Created by Ouimin Lee on 9/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
//                ToolbarItem {
//                    Button(action: updateItem) {
//                        Label("Add Item", systemImage: "pencil")
//                    }
//                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
//    
//    private func updateItem(at index: Int, withNewTimestamp newTimestamp: Date) {
//        withAnimation {
//            // Check if the index is within the valid range
//            guard index >= 0 && index < items.count else { return }
//            
//            // Get the item to update
//            let itemToUpdate = items[index]
//            
//            // Update the item's timestamp
//            itemToUpdate.timestamp = newTimestamp
//            
//            // Update the item in the context
////            modelContext.update(itemToUpdate)
//            
//            // Optionally: Save changes to the context
//            do {
//                try modelContext.save()
//            } catch {
//                // Handle the error (e.g., show an alert or log it)
//                print("Failed to save context: \(error.localizedDescription)")
//            }
//        }
//    }
//    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
