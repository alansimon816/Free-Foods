//
//  AppView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

struct AppView: View {
  @State private var tabSelect = 1

  var body: some View {
    TabView(selection: $tabSelect) {
      FindView()
        .tabItem {Label("Find Eats", systemImage: "magnifyingglass")}
        .tag(1)
      ActivityView()
        .tabItem {Label("Activity", systemImage: "point.3.connected.trianglepath.dotted")}
        .tag(2)
      LeaderboardView()
        .navigationBarHidden(true)
        .tabItem {Label("Leaderboard", systemImage: "chart.bar.xaxis")}
        .tag(3)
      AccountView()
        .navigationBarHidden(true)
        .tabItem {Label("Settings", systemImage: "person.crop.circle")}
        .tag(4)
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
