import Foundation

struct Plant: Identifiable, Codable {
    let id: UUID
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    
    init(id: UUID = UUID(), name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        self.id = id
        self.name = name.isEmpty ? "Pothos" : name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
    }
}
