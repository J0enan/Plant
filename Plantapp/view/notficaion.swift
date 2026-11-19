import Foundation
import UserNotifications

final class NotificationService {

    static let shared = NotificationService()

    private let center = UNUserNotificationCenter.current()

    private init() {}

    func requestPermission() async -> Bool {
        do {
            return try await center.requestAuthorization(
                options: [.alert, .sound, .badge]
            )
        } catch {
            print("Notification permission error: \(error)")
            return false
        }
    }

    func scheduleReminder(for plant: Plant) async {

        guard plant.reminderEnabled else {
            cancelReminder(for: plant)
            return
        }

        let authorized = await requestPermission()

        guard authorized else { return }

        cancelReminder(for: plant)

        var components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: plant.nextWateringDate
        )

        components.hour = plant.reminderHour
        components.minute = plant.reminderMinute

        guard let reminderDate = Calendar.current.date(
            from: components
        ), reminderDate > Date.now else {
            return
        }

        let content = UNMutableNotificationContent()

        content.title = "Time to water your plant! 🌱"
        content.body = "Don't forget to water \(plant.name)."
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )

        do {
            try await center.add(request)
        } catch {
            print("Scheduling error: \(error)")
        }
    }

    func cancelReminder(for plant: Plant) {
        center.removePendingNotificationRequests(
            withIdentifiers: [plant.id.uuidString]
        )
    }

    func cancelAllReminders() {
        center.removeAllPendingNotificationRequests()
    }
}


