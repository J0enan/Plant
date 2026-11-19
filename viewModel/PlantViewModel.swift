import Foundation
import Observation

@Observable
class PlantViewModel {
    // MARK: - Form Inputs (State held by the view model)
    var plantName: String = ""
    var selectedRoom: String = PlantRoom.bedroom.rawValue
    var selectedLight: String = LightRequirement.fullSun.rawValue
    var selectedWateringDays: String = WateringFrequency.everyDay.rawValue
    var selectedWaterAmount: String = WaterAmount.ml20to50.rawValue

    // MARK: - Picker Options Data
    enum PlantRoom: String, CaseIterable, Identifiable {
        case bedroom = "Bedroom"
        case kitchen = "Kitchen"
        case livingRoom = "Living Room"
        case balcony = "Balcony"
        case bathroom = "Bathroom"

        var id: String { rawValue }
    }

    enum LightRequirement: String, CaseIterable, Identifiable {
        case fullSun = "Full Sun"
        case partialSun = "Partial Sun"
        case lowLight = "Low Light"

        var id: String { rawValue }
    }

    enum WateringFrequency: String, CaseIterable, Identifiable {
        case everyDay = "Every day"
        case every2Days = "Every 2 days"
        case every3Days = "Every 3 days"
        case onceAWeek = "Once a week"
        case every10Days = "Every 10 days"
        case every2Weeks = "Every 2 weeks"

        var id: String { rawValue }
    }

    enum WaterAmount: String, CaseIterable, Identifiable {
        case ml20to50 = "20–50 ml"
        case ml50to100 = "50–100 ml"
        case ml100to200 = "100–200 ml"
        case ml200to300 = "200–300 ml"

        var id: String { rawValue }
    }

    // MARK: - Picker Options Arrays (derived from enums)
    var rooms: [String] { PlantRoom.allCases.map { $0.rawValue } }
    var lightOptions: [String] { LightRequirement.allCases.map { $0.rawValue } }
    var wateringFrequency: [String] { WateringFrequency.allCases.map { $0.rawValue } }
    var waterAmounts: [String] { WaterAmount.allCases.map { $0.rawValue } }

    // MARK: - Business Logic
    func buildPlant() -> Plant {
        Plant(
            name: plantName.isEmpty ? "Unnamed Plant" : plantName,
            room: selectedRoom,
            light: selectedLight,
            wateringDays: selectedWateringDays,
            waterAmount: selectedWaterAmount
        )
    }
    func resetForm() {
        plantName = ""
        selectedRoom = rooms[0]
        selectedLight = lightOptions[0]
        selectedWateringDays = wateringFrequency[0]
        selectedWaterAmount = waterAmounts[0]
    }
}
