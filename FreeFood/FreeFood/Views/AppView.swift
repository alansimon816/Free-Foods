//
//  AppView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

// Remove later and change file name to LaunchView instead
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
            .tabItem {Image(systemName: "magnifyingglass")}
          ActivityView()
            .tabItem {Image(systemName: "point.3.filled.connected.trianglepath.dotted")}
          LeaderboardView()
            .navigationBarHidden(true)
            .tabItem {Image(systemName: "chart.bar.xaxis")}
          AccountView()
            .navigationBarHidden(true)
            .tabItem {Image(systemName: "person.crop.circle")}
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
