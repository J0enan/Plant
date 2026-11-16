import Foundation
import SwiftUI

// A simple list view model to back ContentView and SetReminderView
// Holds a list of Plant items and basic operations.
class PlantListViewModel: ObservableObject {
    @Published var plants: [Plant]

    init(plants: [Plant] = []) {
        self.plants = plants
    }

    func add(_ plant: Plant) {
        plants.append(plant)
    }

    func remove(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }
}
