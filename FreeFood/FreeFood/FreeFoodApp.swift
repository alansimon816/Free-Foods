//
//  FreeFoodApp.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import SwiftUI
import Firebase

@main
struct FreeFoodApp: App {
  @StateObject var model = Model()
  let persistenceController = PersistenceController.shared
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(model)
    }
  }
}
