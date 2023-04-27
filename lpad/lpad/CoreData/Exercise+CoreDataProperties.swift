
import Foundation
import CoreData
import WatchConnectivity


extension Exercise {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var repGoal: Int16
    @NSManaged public var setGoal: Int16
    @NSManaged public var weightArray: [Double]?
    @NSManaged public var notes: String?
    @NSManaged public var workout: Workout?
    
    public var wrappedName: String {
        name ?? "no exercise name"
    }
    
    public var wrappedWeightArray: [Double] {
        get { return weightArray ?? [] }
        set {weightArray = newValue}
    }
    
    public var wrappedNotes: String {
        return notes ?? "no notes"
    }
}

extension Exercise : Identifiable {
    
}
