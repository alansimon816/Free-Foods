//
//  AppView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

struct AppView: View {
  var body: some View {
    TabView() {
      FindView()
        .tabItem {Label("Find Eats", systemImage: "magnifyingglass")}
      ActivityView()
        .tabItem {Label("Activity", systemImage: "point.3.filled.connected.trianglepath.dotted")}
      LeaderboardView()
        .navigationBarHidden(true)
        .tabItem {Label("Leaderboard", systemImage: "chart.bar.xaxis")}
      AccountView()
        .navigationBarHidden(true)
        .tabItem {Label("Settings", systemImage: "person.crop.circle")}
    }
    .navigationBarBackButtonHidden(true)
    .onAppear {
      if #available(iOS 15.0, *) {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = appearance
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
