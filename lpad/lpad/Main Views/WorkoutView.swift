

import SwiftUI
import WatchConnectivity


struct WorkoutView: View {
    
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.managedObjectContext) var dbContext
    @Environment(\.dismiss) var dismiss
    @State private var workoutNameInput: String = ""
    
    let workout: Workout
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                if appData.editMode == true {
                    
                    TextField("new workout name...", text: $workoutNameInput)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 250)
                }
                Spacer()
            }
            .frame(height: 35)
            .padding(.leading)
            .background(.clear)
            List {
                if workout.exerciseArray.isEmpty {
                    HStack {
                        Spacer()
                        Text("no exercises")
                            .foregroundColor(.indigo)
                            .font(.body)
                        Spacer()
                    }
                } else {
                    ForEach(workout.exerciseArray) { exercise in
                        ExerciseListBlock(exercise: exercise)
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            dbContext.delete(workout.exerciseArray[index])
                        }
                        do {
                            try dbContext.save()
                        } catch {
                            print("error deleting workout")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $appData.showSheet, content: {
            NewExerciseView(workout: workout)
        })
        .navigationTitle(workout.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.indigo)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    appData.editMode.toggle()
                    if workoutNameInput != "" {
                        Task(priority: .high) {
                            await appData.updateWorkoutName(workout: workout, workoutNameInput: workoutNameInput, dbContext: dbContext)
                        }
                    }
                } label: {
                    Text(appData.editMode ? "Done" : "Edit")
                        .foregroundColor(.indigo)
                        .font(.body)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    appData.showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.indigo)
                }
                
            }
        }
    }
}
