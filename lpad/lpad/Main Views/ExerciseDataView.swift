
import SwiftUI
import WatchConnectivity

struct ExerciseDataView: View {
    
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.managedObjectContext) var dbContext
    @Environment(\.dismiss) var dismiss
    
    
    let exercise: Exercise
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    
                    Text(exercise.wrappedName)
                        .foregroundColor(.indigo)
                        .font(.title)
                        .frame(height: 35)
                    
                    Spacer()
                }
                HStack {
                    Text("sets: \(exercise.setGoal), reps: \(exercise.repGoal)")
                        .foregroundColor(.gray)
                        .font(.callout)
                    Spacer()
                }
                if exercise.wrappedWeightArray != [] {
                    WeightGraphView(exercise: exercise)
                } else if exercise.wrappedWeightArray == [] {
                    Text("no weight data")
                        .foregroundColor(.gray)
                        .frame(width: 350, height: 250)
                        .border(Color.gray).opacity(0.5)
                }
                
                HStack {
                    Text("Notes")
                        .foregroundColor(.indigo)
                        .font(.body)
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text(exercise.wrappedNotes)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                Spacer()
            }
        }.padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.indigo)
                            .font(.body)
                    }
                    
                }
            }
    }
}
