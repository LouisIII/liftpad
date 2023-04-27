//
//  ContentView.swift
//  lpadWatch Watch App
//
//  Created by spencer selden on 4/17/23.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
