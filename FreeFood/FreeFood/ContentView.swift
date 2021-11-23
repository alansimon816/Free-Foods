//
//  ContentView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @EnvironmentObject var simpleAuth: SimpleAuthModel
  var body: some View {
    if simpleAuth.signedIn {
      AppView()
    } else {
      HomeView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
