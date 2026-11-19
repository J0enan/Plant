import SwiftUI

struct SetReminderView: View {
    @Bindable var viewModel: PlantViewModel
    var listViewModel: PlantListViewModel
    var plantToEdit: Plant? = nil

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                // 1. اسم النبتة
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $viewModel.plantName)
                    }
                }

                // 2. الغرفة والإضاءة
                Section {
                    Picker(selection: $viewModel.selectedRoom) {
                        ForEach(viewModel.rooms, id: \.self) { Text($0) }
                    } label: {
                        Label("Room", systemImage: "location")
                            .foregroundStyle(.primary)
                    }

                    Picker(selection: $viewModel.selectedLight) {
                        ForEach(viewModel.lightOptions, id: \.self) { Text($0) }
                    } label: {
                        Label("Light", systemImage: "sun.max")
                            .foregroundStyle(.primary)
                    }
                }

                // 3. السقي
                Section {
                    Picker(selection: $viewModel.selectedWateringDays) {
                        ForEach(viewModel.wateringFrequency, id: \.self) { Text($0) }
                    } label: {
                        Label("Watering Days", systemImage: "drop")
                            .foregroundStyle(.primary)
                    }

                    Picker(selection: $viewModel.selectedWaterAmount) {
                        ForEach(viewModel.waterAmounts, id: \.self) { Text($0) }
                    } label: {
                        Label("Water", systemImage: "drop")
                            .foregroundStyle(.primary)
                        
                    }
                }

                // 4. زر الحذف (يظهر فقط عند التعديل)
                if let plant = plantToEdit {
                    Section {
                        Button(role: .destructive) {
                            listViewModel.deletePlant(plant)
                            dismiss()
                        } label: {
                            Text("Delete Reminder")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        viewModel.resetForm()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        listViewModel.addPlant(viewModel.buildPlant())
                        viewModel.resetForm()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            
                            
                        
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color(red: 0.15, green: 0.38, blue: 0.32))
                     
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    SetReminderView(viewModel: PlantViewModel(), listViewModel: PlantListViewModel())
}
