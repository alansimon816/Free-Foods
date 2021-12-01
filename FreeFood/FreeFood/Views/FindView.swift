//
//  FindView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//
import SwiftUI

struct FindView: View {
  var body: some View {
    VStack {
      HStack {
          NavigationLink(destination: FoodMapView().navigationTitle("Food Map")) {
          Text("Food Map").padding(.horizontal, 10)
        }
        Spacer()
        NavigationLink(destination: FoodSubmissionView()) {
          Text("Submit Eats").padding(.horizontal, 10)
        }
      }
      Divider()
      Spacer()
      FoodFeedView()
    }.navigationBarTitle("", displayMode: .inline)
  }
}
