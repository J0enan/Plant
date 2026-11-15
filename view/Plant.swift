import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                HStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.10))
                    .frame(height: 1)
                    .padding(.top, 0.5)
                    .padding(.horizontal)
                
                // الشرط: إذا لم تكن هناك نباتات، اعرض شاشة البداية. وإذا وُجدت، اعرض القائمة.
                if viewModel.plants.isEmpty {
                    Spacer()
                    
                    VStack(spacing: 12) {
                        Image("P1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        Text("Start your plant journey!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    
                    Spacer()
                    
                    // زر إضافة تذكير للنبات
                    Button(action: {
                        showSetReminder = true
                    }) {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0.15, green: 0.38, blue: 0.32))
                            .cornerRadius(25)
                    }
                    
                    Spacer()
                } else {
                    // قائمة النباتات المضافة
                    Text("Your plants are waiting for a sip 💧")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    List {
                        ForEach(viewModel.plants) { plant in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("📍 in \(plant.room)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text(plant.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                HStack(spacing: 12) {
                                    Label(plant.light, systemImage: "sun.max")
                                    Label(plant.waterAmount, systemImage: "drop")
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .sheet(isPresented: $showSetReminder) {
            SetReminderView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}

