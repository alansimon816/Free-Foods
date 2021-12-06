//
//  FoodEventView.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//

import SwiftUI

struct FoodEventView: View {
  @State private var showAlert = false
  var foodEvent: FoodEvent
  
  var body: some View {
    VStack {
      // Insert small map view here with pin of event on map (takes up top 1/5th of the screen lets say)
      // Clicking on the small map view would take user to a full screen map view
      List {
        NavigationLink(destination: UserDetailView()) {
          LabeledText(label: "Submitted by", text:foodEvent.username)
        }
        LabeledText(label: "Restaurant", text:foodEvent.foodType)
        LabeledText(label: "Quantity", text:foodEvent.quantity)
        LabeledText(label: "Building", text:foodEvent.building)
        LabeledText(label: "Room", text:foodEvent.roomNum)
        LabeledText(label: "Additional Info", text:foodEvent.additionalInfo)
      }
      Spacer()
      Button(action: {
        print("Go button pressed")
        // draw route from user location to food event coordinates
      }) {
        HStack {
          Text("Go!")
            .fontWeight(.semibold)
            .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.leading)
        .padding(.trailing)
      }
      
      Button(action: {
        print("Report Event as Expired button pressed")
        showAlert = true
      }) {
        HStack {
          Text("Report Event as Expired")
            .fontWeight(.semibold)
            .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color.red)
        .cornerRadius(10)
        .padding(.leading)
        .padding(.trailing)
      }
      .alert("Are you sure you would like to report this event as expired?", isPresented: $showAlert) {
        Button("Yes", role: .destructive) {}
      }
      
    }.navigationTitle("Food Event Details")
  }
}

struct LabeledText: View {
  var label: String
  var text: String
  
  var body: some View {
    HStack {
      Text("\(label): ").fontWeight(.bold)
      Text(text)
    }
  }
}
