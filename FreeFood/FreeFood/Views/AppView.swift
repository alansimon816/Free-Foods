//
//  AppView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/19/21.
//

import SwiftUI

struct AppView: View {
  
  var body: some View {
    // We should add system images for each of these tab items
    NavigationView {
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
      }.navigationBarBackButtonHidden(true)
    }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
