//
//  ContentView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @EnvironmentObject var sam: SimpleAuthModel
  var body: some View {
    HomeView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
