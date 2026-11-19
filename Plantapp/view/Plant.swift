import SwiftUI

struct ContentView: View {
    @State private var listViewModel = PlantListViewModel()
    @State private var plantForm = PlantViewModel()
    @State private var showSetReminder = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                titleBar

                if listViewModel.plants.isEmpty {
                    if listViewModel.hasEverAddedPlant {
                        noRemindersState      
                    } else {
                        emptyState
                    }
                } else if listViewModel.allDone {
                    allDoneState
                } else {
                    plantList
                }
            }

            if !listViewModel.plants.isEmpty || listViewModel.hasEverAddedPlant {
                addButton
            }
        }
        // باقي الـ modifiers (.sheet وغيرها) تبقى كما هي
    
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSetReminder) {
            SetReminderView(viewModel: plantForm, listViewModel: listViewModel)
        }
    }
}

// MARK: - الأجزاء
extension ContentView {

    // العنوان والخط الفاصل
    private var titleBar: some View {
        VStack(spacing: 8) {
            HStack {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)

            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 0.5)
                .padding(.horizontal)
        }
        .padding(.top, 8)
    }

    // الحالة 1: ما فيه نباتات
    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()

            Image("P1")
                .resizable()
                .scaledToFit()
                .frame(width: 164, height: 200)
                

            Text("Start your plant journey!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()

            Button {
                showSetReminder = true
            } label: {
                Text("Set Plant Reminder")
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 50)
            }
            .buttonStyle(.glassProminent)
            .opacity(2)
            .buttonBorderShape(.capsule)
            .tint(Color.plantGreen)
            .padding(.bottom, 40)
        }
    }
    // الحالة 2: حذفت كل النباتات
    private var noRemindersState: some View {
            VStack {
                Spacer()
                Text("No reminders set yet..")
                    
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    // الحالة 2: القائمة
    private var plantList: some View {
        VStack(spacing: 12) {
            progressHeader

            List {
                ForEach(listViewModel.plants) { plant in
                    PlantRowView(plant: plant) {
                        withAnimation {
                            listViewModel.toggleWatered(plant)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Color.gray.opacity(0.4))
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            listViewModel.deletePlant(plant)
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .padding(.top, 12)
    }

    // الجملة + الخط المتحرك
    private var progressHeader: some View {
        VStack(spacing: 14) {
            Text(listViewModel.wateredCount == 0
                 ? "Your plants are waiting for a sip 💦"
                 : "\(listViewModel.wateredCount) of your plants feel loved today ✨")
                .font(.body)
                .foregroundStyle(.white)
            PlantProgressBar(progress: listViewModel.progress)

//            PlantProgressBar(progress: listViewModel.progress)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    // الحالة 3: كل النباتات انسقت
    private var allDoneState: some View {
        VStack(spacing: 12) {
            Spacer()

            Image("P2")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 200)
                .offset(x: 6)
                
            
            Text("All Done! 🎉")
                .font(.title3)
                .fontWeight(.bold)
                
            Text("All Reminders Completed")
                .font(.subheadline)
                .foregroundStyle(.gray)
               
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    // زر + العائم
    private var addButton: some View {
        Button {
            showSetReminder = true
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .frame(width: 36, height: 36)
        }
        .buttonStyle(.glassProminent)
        .buttonBorderShape(.circle)
        .tint(Color.plantGreen)
        .padding(.trailing, 24)
        .padding(.bottom, 16)
    }
}

#Preview {
    ContentView()
}
