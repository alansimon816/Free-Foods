//
//  AppView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

struct AppView: View {
  var recentRegister: Bool
  // This view is after a successful login
  var body: some View {
    LaunchView(recentRegister: recentRegister)
  }
}

struct LaunchView: View {
  var recentRegister: Bool
  
  var body: some View {
    // We should add system images for each of these tab items
    NavigationView {
      if recentRegister {
        RegistrationView()
      } else {
        TabView() {
          FindView()
            .tabItem {Text("Find")}
          ActivityView()
            .tabItem {Text("Activity")}
          LeaderboardView()
            .navigationBarHidden(true)
            .tabItem {Text("Leaderboard")}
          AccountView()
            .navigationBarHidden(true)
            .tabItem {Text("Account")}
        }
      }
    }.navigationBarBackButtonHidden(true)
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(recentRegister: false)
  }
}
