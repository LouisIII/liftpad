
import SwiftUI
import WatchConnectivity


struct NewExerciseView: View {
    
    @Environment(\.managedObjectContext) var dbContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appData: ApplicationData
    
    @State private var exerciseNameInput: String = ""
    @State private var exerciseRepGoalInput: String = ""
    @State private var exerciseSetGoalInput: String = ""
    @State private var exerciseNotesInput: String = ""
    
    var workout: Workout
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    if exerciseNameInput != "" && exerciseRepGoalInput != "" && exerciseSetGoalInput != "" {
                        Task(priority: .high) {
                            await appData.saveNewExercise(name: exerciseNameInput, reps: exerciseRepGoalInput, sets: exerciseSetGoalInput, notes: exerciseNotesInput, workout: workout, dbContext: dbContext)
                        }
                        appData.showSheet = false
                    }
                    print("save exercise and add exercise to workout")
                    dismiss()
                } label: {
                    Text("save")
                        .foregroundColor(.indigo)
                        .font(.body)
                }
                .padding(.trailing, 30)
            }
            HStack {
                Spacer()
                Text("new exercise")
                    .foregroundColor(.indigo)
                    .font(.body)
                Spacer()
            }
            HStack {
                Spacer()
                TextField("exercise name...", text: $exerciseNameInput)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 250)
                    .textInputAutocapitalization(.never)
                Spacer()
            }
            HStack {
                Spacer()
                Text("set goal:")
                    .foregroundColor(.indigo)
                    .font(.body)
                TextField("0", text: $exerciseSetGoalInput)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 50)
                    .keyboardType(.numberPad)
                Spacer()
            }
            HStack {
                Spacer()
                Text("rep goal:")
                    .foregroundColor(.indigo)
                    .font(.body)
                TextField("0", text: $exerciseRepGoalInput)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 50)
                    .keyboardType(.numberPad)
                Spacer()
            }
            HStack {
                Text("notes:")
                    .foregroundColor(.indigo)
                    .font(.body)
                Spacer()
            }
            HStack {
                Spacer()
                TextEditor(text: $exerciseNotesInput)
                    .frame(height: 150)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .border(.gray.opacity(0.2))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
