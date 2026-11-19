import Foundation
import Observation

@Observable
class PlantListViewModel {
    var plants: [Plant] = []
    var hasEverAddedPlant = false
    

    // MARK: - Computed
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var allDone: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    var progress: Double {
        plants.isEmpty ? 0 : Double(wateredCount) / Double(plants.count)
    }

    // MARK: - Actions
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        hasEverAddedPlant = true   
        
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }

    func toggleWatered(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index].isWatered.toggle()
    }
    
}
