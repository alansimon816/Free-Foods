//
//  FindView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import Foundation
import SwiftUI

// View for finding food
struct FindView: View {
  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(destination: Text("Find View")) {
          Text("FindView")
        }
        NavigationLink(destination: FoodSubmissionView()) {
          Text("Submit Eats")
        }
      }
    }
  }
}
