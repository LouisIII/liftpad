//
//  lpadApp.swift
//  lpad
//
//  Created by spencer selden on 4/5/23.
//

import SwiftUI
import WatchConnectivity

@main
struct lpadApp: App {
    
    //creating stateObjects to manage the application and quote manager data models
    @StateObject var appData = ApplicationData()
    @StateObject var quoteManager = QuoteManager()
    
    var body: some Scene {
       
        //adding both applicationData and quoteManager to the enviornment
        WindowGroup {
            WorkoutListView()
                .environmentObject(appData)
                .environmentObject(quoteManager)
                .environment(\.managedObjectContext, appData.container.viewContext)
        }
    }
}
