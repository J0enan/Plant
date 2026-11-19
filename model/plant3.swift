import Foundation

struct Plant: Identifiable, Codable {
    let id: UUID
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isWatered: Bool = false

    // Reminder properties
    var reminderEnabled: Bool = false
    var nextWateringDate: Date = Date()
    var reminderHour: Int = 9
    var reminderMinute: Int = 0

    init(
        id: UUID = UUID(),
        name: String,
        room: String,
        light: String,
        wateringDays: String,
        waterAmount: String,
        isWatered: Bool = false,
        reminderEnabled: Bool = false,
        nextWateringDate: Date = Date(),
        reminderHour: Int = 9,
        reminderMinute: Int = 0
    ) {
        self.id = id
        self.name = name.isEmpty ? "pothos " : name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.isWatered = isWatered
        self.reminderEnabled = reminderEnabled
        self.nextWateringDate = nextWateringDate
        self.reminderHour = reminderHour
        self.reminderMinute = reminderMinute
    }
}
