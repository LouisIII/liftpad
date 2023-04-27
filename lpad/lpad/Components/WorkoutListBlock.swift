

import SwiftUI
import WatchConnectivity


struct WorkoutListBlock: View {
    
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.managedObjectContext) var dbContext
    
    let workout: Workout
    
    var body: some View {
        NavigationLink {
            WorkoutView(workout: workout)
        } label: {
            HStack {
                Text(workout.wrappedName)
                    .foregroundColor(.indigo)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
    }
}

