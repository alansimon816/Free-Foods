//
//  ContentView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        // We should add system images for each of these tab items
        TabView() {
            FindView().tabItem {Text("Find")}
            ActivityView().tabItem {Text("Activity")}
            LeaderboardView().tabItem {Text("Leaderboard")}
            AccountView().tabItem {Text("Account")}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
