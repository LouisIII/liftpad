

import SwiftUI
import CoreData
import WatchConnectivity


struct NewWorkoutView: View {
    
    @Environment(\.managedObjectContext) var dbContext
    @EnvironmentObject var appData: ApplicationData
    @State private var workoutNameInput: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    if workoutNameInput != "" {
                        Task(priority: .high) {
                            await appData.storeWorkout(name: workoutNameInput, dbContext: dbContext)
                        }
                        appData.showSheet = false
                    }
                } label: {
                    Text("save")
                        .foregroundColor(.indigo)
                }
            }
            .padding([.trailing], 30)
            HStack{
                Spacer()
                Text("new workout name")
                    .foregroundColor(.indigo)
                    .font(.body)
                Spacer()
            }
            HStack {
                Spacer()
                TextField("workout name...", text: $workoutNameInput)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 250)
                    .textInputAutocapitalization(.never)
                Spacer()
            }
            Spacer()
        }.padding()
    }
}
