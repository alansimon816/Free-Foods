//
//  LaunchView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

struct LaunchView: View {
  var recentRegister: Bool
  
  var body: some View {
    // We should add system images for each of these tab items
    if recentRegister {
      RegistrationView()
    } else {
      TabView() {
        FindView()
          .navigationBarBackButtonHidden(true)
          .tabItem {Text("Find")}
        ActivityView()
          .navigationBarBackButtonHidden(true)
          .tabItem {Text("Activity")}
        LeaderboardView()
          .navigationBarBackButtonHidden(true)
          .tabItem {Text("Leaderboard")}
        AccountView()
          .navigationBarBackButtonHidden(true)
          .tabItem {Text("Account")}
      }
    }
  }
}

struct LaunchView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchView(recentRegister: false)
  }
}
