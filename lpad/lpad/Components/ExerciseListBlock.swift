
import SwiftUI
import WatchConnectivity

struct ExerciseListBlock: View {
    
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.managedObjectContext) var dbContext
    
    @State private var exerciseWeightInput: String = ""
    @State private var weightSaved: Bool = false
    
    let exercise: Exercise
    
    var body: some View {
        HStack {
            NavigationLink(destination: {
                ExerciseDataView(exercise: exercise)
            }, label: {
                VStack {
                    HStack {
                        
                        Text(exercise.wrappedName)
                            .foregroundColor(.indigo)
                            .font(.body)
                        Spacer()
                    }
                    HStack {
                        Text("sets: \(exercise.setGoal), reps: \(exercise.repGoal)")
                            .foregroundColor(.gray)
                            .font(.callout)
                        Spacer()
                    }
                }
            })
            if weightSaved == true {
                Text(exerciseWeightInput)
                    .foregroundColor(.indigo)
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(width: 100, height: 35)
            } else if weightSaved == false {
                TextField(String(exercise.wrappedWeightArray.last ?? 0.0), text: $exerciseWeightInput)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 100, height: 35)
            }
            Button {
                if weightSaved == false && exerciseWeightInput != "" {
                    Task(priority: .high) {
                        await appData.addWeightToExerciseWeightArray(exercise: exercise, exerciseWeightInput: exerciseWeightInput, dbContext: dbContext)
                    }
                    weightSaved.toggle()
                } else if weightSaved == true && exerciseWeightInput != "" {
                    Task(priority: .high) {
                        await appData.removeLastWeightFromExerciseWeightArray(exercise: exercise, dbContext: dbContext)
                    }
                    weightSaved.toggle()
                }
            } label: {
                Image(systemName: weightSaved ? "checkmark.square.fill" : "checkmark.square")
                    .foregroundColor(.indigo)
                    .font(.title)
                    .frame(width: 35, height: 35)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
}
