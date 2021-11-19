//
//  FreeFoodApp.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct FreeFoodApp: App {
  @StateObject var model = Model()
  @StateObject var simpleAuth = SimpleAuthModel()
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(model)
        .environmentObject(simpleAuth)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    // Initializes Firebase
    FirebaseApp.configure()
    return true
  }
  
  func application(_ application: UIApplication, open url: URL,
                   options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
    // Initializes Google Sign In
    return GIDSignIn.sharedInstance.handle(url)
  }
}
