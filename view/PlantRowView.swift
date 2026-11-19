import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            // الدائرة
            Button(action: onToggle) {
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 26))
                    .foregroundStyle(plant.isWatered ? Color.checkGreen : Color.gray)
            }
            .buttonStyle(.plain)

            // معلومات النبتة
            VStack(alignment: .leading) {
                Label("in \(plant.room)", systemImage: "location")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(plant.name)
                    .font(.title3)
                    .fontWeight(.medium)

                HStack(spacing: 6) {
                    tag(plant.light, icon: "sun.max")
                        .foregroundStyle(.yellow)
                    tag(plant.waterAmount, icon: "drop")
                        .foregroundStyle(.blue)
                }
            }
            .opacity(plant.isWatered ? 0.4 : 1)
            .animation(.easeInOut, value: plant.isWatered)


            Spacer()
        }
        .padding(.vertical, 8)
    }

    // الكبسولة الصغيرة
    private func tag(_ text: String, icon: String) -> some View {
            Label(text, systemImage: icon)
                .labelStyle(.titleAndIcon)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.1), in: Capsule())
        }
}
#Preview {
    SetReminderView(viewModel: PlantViewModel(), listViewModel: PlantListViewModel())
}

