//
//  AppView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

struct AppView: View {
  // This view is after a successful login
  var body: some View {
    // We should add system images for each of these tab items
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
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
