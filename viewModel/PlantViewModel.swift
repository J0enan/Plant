
import SwiftUI
import Observation



@Observable

class AddPlantViewModel {
    // MARK: - Form Inputs (State)
    var plantName: String = "Pothos"
    var selectedRoom: String = "Bedroom"
    var selectedLight: String = "Full sun"
    var selectedWateringDays: String = "Every day"
    var selectedWaterAmount: String = "20-50 ml"
    
    // MARK: - Picker Options Data
    let rooms = ["Bedroom", "Kitchen", "Living Room", "Balcony"]
    let lightOptions = ["Full sun", "Partial shade", "Low light"]
    let wateringFrequency = ["Every day", "Every 2 days", "Weekly"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml"]
    
    // MARK: - Business Logic
    func buildPlant() -> Plant {
        return Plant(
            name: plantName.isEmpty ? "Unnamed Plant" : plantName,
            room: selectedRoom,
            light: selectedLight,
            wateringDays: selectedWateringDays,
            waterAmount: selectedWaterAmount
        )
    }
}
