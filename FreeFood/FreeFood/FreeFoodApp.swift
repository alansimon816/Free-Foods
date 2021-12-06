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
  @StateObject var sam = SimpleAuthModel()
  @StateObject var lm = LocationManager()
  @StateObject var vm = FoodEventViewModel()
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(sam)
        .environmentObject(model)
        .environmentObject(lm)
        .environmentObject(vm)
    }
  }
}
