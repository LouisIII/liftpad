
import Foundation
import SwiftUI
import CoreData
import WatchConnectivity


class ApplicationData: ObservableObject {
    
    //global boolean variables to control sheet navigation and edit modes
    @Published var showSheet: Bool = false
    @Published var editMode: Bool = false
    
    //creating a container for the persistent store and contianer to be used with CoreData
    let container: NSPersistentContainer
    
    //MARK: Workout Methods
    
    func storeWorkout(name: String, dbContext: NSManagedObjectContext) async {
        await dbContext.perform {
            let newWorkout = Workout(context: dbContext)
            newWorkout.name = name
            do {
                try dbContext.save()
            } catch {
                print("error saving workout")
            }
        }
    }
    
    func updateWorkoutName(workout: Workout, workoutNameInput: String, dbContext: NSManagedObjectContext) async {
        await dbContext.perform {
            workout.name = workoutNameInput
            do {
                try dbContext.save()
            } catch {
                print("error saving workout")
            }
        }
    }
    
    //MARK: Exercise Methods
    
    func saveNewExercise(name: String, reps: String, sets: String, notes: String, workout: Workout, dbContext: NSManagedObjectContext) async {
        await dbContext.perform {
            let newExercise = Exercise(context: dbContext)
            newExercise.name = name
            newExercise.repGoal = Int16(reps) ?? 0
            newExercise.setGoal = Int16(sets) ?? 0
            newExercise.notes = notes
            newExercise.workout = workout
            do {
                try dbContext.save()
            } catch {
                print("error saving workout")
            }
        }
    }
    
    func addWeightToExerciseWeightArray(exercise: Exercise, exerciseWeightInput: String, dbContext: NSManagedObjectContext) async {
        if exerciseWeightInput != "" {
            await dbContext.perform {
                exercise.wrappedWeightArray.append(Double(exerciseWeightInput)!)
                do {
                    try dbContext.save()
                } catch {
                    print("error saving workout")
                }
            }
        }
    }
    
    func removeLastWeightFromExerciseWeightArray(exercise: Exercise, dbContext: NSManagedObjectContext) async {
        if exercise.wrappedWeightArray.count != 0 {
            await dbContext.perform {
                exercise.wrappedWeightArray.removeLast()
                do {
                    try dbContext.save()
                } catch {
                    print("error saving workout")
                }
            }
        }
    }
    
    //MARK: Testing Methods
    
    func createTestingData(dbContext: NSManagedObjectContext) async {
        await dbContext.perform {
            //creating workouts
            let workout1 = Workout(context: dbContext)
            workout1.name = "chest"
            
            let workout2 = Workout(context: dbContext)
            workout2.name = "back"
            
            let workout3 = Workout(context: dbContext)
            workout3.name = "shoulders & arms"
            
            let workout4 = Workout(context: dbContext)
            workout4.name = "legs"
            
            //creating exercises and signing them to workouts
            let exercise1 = Exercise(context: dbContext)
            exercise1.name = "bench press"
            exercise1.repGoal = 10
            exercise1.setGoal = 4
            exercise1.notes = "use dumbbells up to 180lbs total weight"
            exercise1.weightArray = [100.0, 100.0, 110.0, 110.0, 120.0, 120.0, 120.0, 135.0, 140.0, 150.0, 160.0, 160.0]
            exercise1.workout = workout1
            
            let exercise2 = Exercise(context: dbContext)
            exercise2.name = "incline bench press"
            exercise2.repGoal = 10
            exercise2.setGoal = 4
            exercise2.notes = "use dumbbells up to 180lbs total weight"
            exercise2.weightArray = [90.0, 90.0, 90.0, 100.0, 100.0, 100.0, 115.0, 115.0, 120.0, 120.0, 120.0, 120.0]
            exercise2.workout = workout1
            
            let exercise3 = Exercise(context: dbContext)
            exercise3.name = "chest fly"
            exercise3.repGoal = 10
            exercise3.setGoal = 4
            exercise3.notes = ""
            exercise3.weightArray = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 25.0, 25.0, 30.0, 30.0, 30.0, 35.0]
            exercise3.workout = workout1
            
            let exercise4 = Exercise(context: dbContext)
            exercise4.name = "dumbbell pullover"
            exercise4.repGoal = 10
            exercise4.setGoal = 4
            exercise4.notes = ""
            exercise4.weightArray = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 25.0, 25.0, 30.0, 30.0, 30.0, 40.0]
            exercise4.workout = workout1
            
            let exercise5 = Exercise(context: dbContext)
            exercise5.name = "dips"
            exercise5.repGoal = 10
            exercise5.setGoal = 4
            exercise5.notes = ""
            exercise5.weightArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            exercise5.workout = workout1
            
            let exercise6 = Exercise(context: dbContext)
            exercise6.name = "pull ups"
            exercise6.repGoal = 10
            exercise6.setGoal = 4
            exercise6.notes = "do lat pulldown until you can do unasisted pull ups"
            exercise6.weightArray = [100.0, 100.0, 100.0, 110.0, 110.0, 110.0, 120.0, 120.0, 120.0, 120.0, 120.0, 120.0]
            exercise6.workout = workout2
            
            let exercise7 = Exercise(context: dbContext)
            exercise7.name = "chin ups"
            exercise7.repGoal = 10
            exercise7.setGoal = 4
            exercise7.notes = "do reverse grip lat pulldown until you can do unasisted chin ups"
            exercise7.weightArray = [100.0, 100.0, 100.0, 110.0, 110.0, 110.0, 120.0, 120.0, 120.0, 120.0, 120.0, 120.0]
            exercise7.workout = workout2
            
            let exercise8 = Exercise(context: dbContext)
            exercise8.name = "seated row"
            exercise8.repGoal = 10
            exercise8.setGoal = 4
            exercise8.notes = "alternate between using machine and barbell"
            exercise8.weightArray = [80.0, 80.0, 80.0, 90.0, 90.0, 90.0, 100.0, 100.0, 100.0, 110.0, 110.0, 120.0]
            exercise8.workout = workout2
            
            let exercise9 = Exercise(context: dbContext)
            exercise9.name = "deadlift"
            exercise9.repGoal = 10
            exercise9.setGoal = 4
            exercise9.notes = "don't hurt yourself"
            exercise9.weightArray = [80.0, 80.0, 80.0, 90.0, 90.0, 90.0, 100.0, 100.0, 100.0, 110.0, 110.0, 120.0]
            exercise9.workout = workout2
            
            
            let exercise10 = Exercise(context: dbContext)
            exercise10.name = "bent over flys"
            exercise10.repGoal = 10
            exercise10.setGoal = 4
            exercise10.notes = "lean forward at a 45 degree angle"
            exercise10.weightArray = [10.0, 10.0, 10.0, 20.0, 20.0, 20.0, 30.0, 30.0, 30.0, 40.0, 40.0, 40.0]
            exercise10.workout = workout2
            
            let exercise11 = Exercise(context: dbContext)
            exercise11.name = "military press"
            exercise11.repGoal = 10
            exercise11.setGoal = 4
            exercise11.notes = "can be seated with dumbbell or standing with barbell"
            exercise11.weightArray = [70.0, 70.0, 70.0, 75.0, 75.0, 80.0, 80.0, 90.0, 90.0, 90.0, 100.0, 100.0]
            exercise11.workout = workout3
            
            let exercise12 = Exercise(context: dbContext)
            exercise12.name = "upright row"
            exercise12.repGoal = 10
            exercise12.setGoal = 4
            exercise12.notes = ""
            exercise12.weightArray = [70.0, 70.0, 70.0, 75.0, 75.0, 80.0, 80.0, 90.0, 90.0, 90.0, 100.0, 100.0]
            exercise12.workout = workout3
            
            let exercise13 = Exercise(context: dbContext)
            exercise13.name = "lateral raise"
            exercise13.repGoal = 10
            exercise13.setGoal = 4
            exercise13.notes = "slow reps constant tension"
            exercise13.weightArray = [10.0, 10.0, 10.0, 15.0, 15.0, 20.0, 20.0, 20.0, 25.0, 30.0, 30.0, 30.0]
            exercise13.workout = workout3
            
            let exercise14 = Exercise(context: dbContext)
            exercise14.name = "front raise"
            exercise14.repGoal = 10
            exercise14.setGoal = 4
            exercise14.notes = "slow reps constant tension"
            exercise14.weightArray = [10.0, 10.0, 10.0, 15.0, 15.0, 20.0, 20.0, 20.0, 25.0, 30.0, 30.0, 30.0]
            exercise14.workout = workout3
            
            let exercise15 = Exercise(context: dbContext)
            exercise15.name = "barbell curl"
            exercise15.repGoal = 10
            exercise15.setGoal = 4
            exercise15.notes = "slow reps constant tension"
            exercise15.weightArray = [20.0, 20.0, 30.0, 35.0, 35.0, 40.0, 40.0, 40.0, 45.0, 50.0, 50.0, 50.0]
            exercise15.workout = workout3
            
            let exercise16 = Exercise(context: dbContext)
            exercise16.name = "dumbbell curl"
            exercise16.repGoal = 10
            exercise16.setGoal = 4
            exercise16.notes = "slow reps constant tension"
            exercise16.weightArray = [10.0, 10.0, 20.0, 25.0, 25.0, 30.0, 30.0, 30.0, 35.0, 40.0, 40.0, 40.0]
            exercise16.workout = workout3
            
            let exercise17 = Exercise(context: dbContext)
            exercise17.name = "close grip bench"
            exercise17.repGoal = 10
            exercise17.setGoal = 4
            exercise17.notes = "keep elbows tucked in"
            exercise17.weightArray = [80.0, 80.0, 80.0, 85.0, 85.0, 90.0, 90.0, 90.0, 95.0, 100.0, 100.0, 100.0]
            exercise17.workout = workout3
            
            let exercise18 = Exercise(context: dbContext)
            exercise18.name = "tricep extension lg"
            exercise18.repGoal = 10
            exercise18.setGoal = 4
            exercise18.notes = "have palms facing down"
            exercise18.weightArray = [40.0, 40.0, 40.0, 45.0, 45.0, 50.0, 50.0, 50.0, 55.0, 60.0, 60.0, 60.0]
            exercise18.workout = workout3
            
            let exercise19 = Exercise(context: dbContext)
            exercise19.name = "tricep extension vg"
            exercise19.repGoal = 10
            exercise19.setGoal = 4
            exercise19.notes = "have palms facing in"
            exercise19.weightArray = [40.0, 40.0, 40.0, 45.0, 45.0, 50.0, 50.0, 50.0, 55.0, 60.0, 60.0, 60.0]
            exercise19.workout = workout3
            
            let exercise20 = Exercise(context: dbContext)
            exercise20.name = "bodyweight squat"
            exercise20.repGoal = 10
            exercise20.setGoal = 4
            exercise20.notes = "keep hips underneath you"
            exercise20.weightArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            exercise20.workout = workout4
            
            let exercise21 = Exercise(context: dbContext)
            exercise21.name = "barbell squat"
            exercise21.repGoal = 10
            exercise21.setGoal = 4
            exercise21.notes = "keep hips underneath you"
            exercise21.weightArray = [80.0, 80.0, 80.0, 90.0, 90.0, 100.0, 100.0, 120.0, 120.0,135.0, 135.0, 135.0]
            exercise21.workout = workout4
            
            let exercise22 = Exercise(context: dbContext)
            exercise22.name = "stationary lunges"
            exercise22.repGoal = 10
            exercise22.setGoal = 4
            exercise22.notes = "slow reps constant tension"
            exercise22.weightArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            exercise22.workout = workout4
            
            let exercise23 = Exercise(context: dbContext)
            exercise23.name = "leg extension"
            exercise23.repGoal = 10
            exercise23.setGoal = 4
            exercise23.notes = ""
            exercise23.weightArray = [80.0, 80.0, 80.0, 90.0, 90.0, 100.0, 100.0, 120.0, 120.0,135.0, 135.0, 135.0]
            exercise23.workout = workout4
            
            let exercise24 = Exercise(context: dbContext)
            exercise24.name = "leg curl"
            exercise24.repGoal = 10
            exercise24.setGoal = 4
            exercise24.notes = ""
            exercise24.weightArray = [70.0, 70.0, 70.0, 80.0, 80.0, 90.0, 90.0, 100.0, 100.0,115.0, 115.0, 115.0]
            exercise24.workout = workout4
            
            let exercise25 = Exercise(context: dbContext)
            exercise25.name = "crab walk"
            exercise25.repGoal = 10
            exercise25.setGoal = 4
            exercise25.notes = "stay low the entire time, hips underneath you"
            exercise25.weightArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            exercise25.workout = workout4
            
            do {
                try dbContext.save()
            } catch {
                print("error saving workout")
            }
        }
    }
    //MARK: Initializers
    
    init() {
        container = NSPersistentContainer(name: "lpadDataModel")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
}
