//
//  FindView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//
import SwiftUI

struct FindView: View {

  var body: some View {
    NavigationView {
      VStack {
          HStack {
              NavigationLink(destination: Text("Find Map")) {
                  Text("Find Map").padding(.horizontal, 10)
              }
              Spacer()
              NavigationLink(destination: FoodSubmissionView()) {
                Text("Submit Eats").padding(.horizontal, 10)
              }
          }
          Divider()
          Spacer()
          FoodFeedView()
      }
    }.navigationBarTitle("")
     .navigationBarHidden(true)
  }
}
