//
//  FindView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//
import SwiftUI

struct FindView: View {

  @State var showSheet = false
  @State var showMap = false
  var body: some View {
    VStack {
      HStack {
        NavigationLink(destination: FoodMapView(), isActive: $showMap) {
          EmptyView()
        }
        Button(action: {
          showMap = true
        }) {
          Text("Find Eats")
            .padding(.horizontal, 10)
            .foregroundColor(.accentColor)
        }
        
        Spacer()
        
        Button(action: {
          showSheet = true
        }) {
          Text("Submit Eats")
            .padding(.horizontal, 10)
            .foregroundColor(.accentColor)
        }.fullScreenCover(isPresented: $showSheet,
                          onDismiss: { showSheet = false }) {
          NavigationView {
            FoodSubmissionView(showSubmission: $showSheet)
          }
        }
      }
      FoodFeedView()
    }.navigationBarTitle("", displayMode: .inline)
  }
}
