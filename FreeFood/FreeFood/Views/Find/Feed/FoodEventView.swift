//
//  FoodEventView.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//

import SwiftUI

struct FoodEventView: View {
  var foodEvent: FoodEvent
  
  var body: some View {
    VStack {
      // Insert small map view here with pin of event on map (takes up top 1/5th of the screen lets say)
      // Clicking on the small map view would take user to a full screen map view
      Text("Submitted by: \(foodEvent.username)")
      Text("Building: \(foodEvent.building)")
      Text("Room #: \(foodEvent.roomNum)")
      Text("Restaurant: \(foodEvent.foodType)")
      Text("Quantity: \(foodEvent.quantity)")
      Text("Additional Info: \(foodEvent.additionalInfo)")
    }
  }
}
