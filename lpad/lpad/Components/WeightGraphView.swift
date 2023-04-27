
import SwiftUI
import Charts
import WatchConnectivity

struct WeightGraphView: View {
    
    @EnvironmentObject var appData: ApplicationData
    
    var exercise: Exercise
    
    //converting the weight array values into tuples to be used in the chart
    var data: [(Int, Double)] {
        Array(zip(Array(1...exercise.wrappedWeightArray.count), exercise.weightArray!))
    }
    
    
    var body: some View {
        VStack {
            Chart(data, id: \.0) { tuple in
                PointMark(x: .value("workouts", tuple.0), y: .value("weight", tuple.1))
            }
            .frame(height: 250)
            .chartYScale(domain: Double(exercise.wrappedWeightArray.min() ?? 0.0)...(exercise.wrappedWeightArray.max() ?? 300.0)+10)
            .foregroundColor(.indigo)
            .padding()
        }
    }
}
