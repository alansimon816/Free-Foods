//
//  ContentView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  var body: some View {
    HomeView()
      .frame(width: 400, height: 600, alignment: .center)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
