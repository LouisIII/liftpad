//
//  lpadWatchApp.swift
//  lpadWatch Watch App
//
//  Created by spencer selden on 4/17/23.
//

import SwiftUI
import WatchConnectivity

@main
struct lpadWatch_Watch_AppApp: App {
    
    @StateObject var appData = ApplicationData()
    @StateObject var quoteManager = QuoteManager()
    
    var body: some Scene {
        WindowGroup {
            WorkoutListView()
                .environmentObject(appData)
                .environmentObject(quoteManager)
                .environment(\.managedObjectContext, appData.container.viewContext)
        }
    }
}
