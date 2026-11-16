import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: PlantListViewModel
    

    var body: some View {
        VStack {
            Text("Set Reminder")
                .font(.title)
                .padding()
            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
    }
}

