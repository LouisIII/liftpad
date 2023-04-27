

import SwiftUI
import CoreData
import WatchConnectivity

struct WorkoutListView: View {
    
    @Environment(\.managedObjectContext) var dbContext
    @FetchRequest(sortDescriptors: []) var listOfWorkouts: FetchedResults<Workout>
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var quoteManager: QuoteManager
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if listOfWorkouts.isEmpty {
                        HStack {
                            Spacer()
                            Text("no workouts")
                                .foregroundColor(.indigo)
                                .font(.body)
                            Spacer()
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button {
                                    Task(priority: .high) {
                                        await appData.createTestingData(dbContext: dbContext)
                                    }
                                } label: {
                                    Text("populate data for testing")
                                        .foregroundColor(.indigo)
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    
                    ForEach(listOfWorkouts) { workout in
                        WorkoutListBlock(workout: workout)
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            dbContext.delete(listOfWorkouts[index])
                        }
                        do {
                            try dbContext.save()
                        } catch {
                            print("error deleting workout")
                        }
                    }
//                    Section("daily quote") {
//                        Text(quoteManager.dailyQuote)
//                            .foregroundColor(.indigo)
//                    }
                    
                }
                Spacer()
            }
            .onAppear {
                quoteManager.performRequest(urlString: quoteManager.quoteURL)
            }
            .sheet(isPresented: $appData.showSheet, content: {
                NewWorkoutView()
                
            })
            .alert("Error", isPresented: $quoteManager.openAlert, actions: {
                Button("Cancel",role: .cancel, action: {
                    quoteManager.openAlert = false
                })
            }, message: { Text("error connecting to network")})
            
            .navigationTitle(Text("workout list"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        appData.showSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.indigo)
                    }
                    
                }
            }
        }
    }
}
