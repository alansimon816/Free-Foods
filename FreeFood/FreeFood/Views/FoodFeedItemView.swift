//
//  FoodFeedItemView.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//

import SwiftUI

struct FoodFeedItemView: View {
    var foodEvent: FoodEvent
    
    init(_ foodEvent: FoodEvent) {
        self.foodEvent = foodEvent
    }
    
    var body: some View {
        HStack {
            Image(systemName: "bolt.circle.fill") //placeholder img; replace with an image corresponding to each case of Food enum or restaurant logo if food event is restaurant-based
            VStack {
                Text(foodEvent.foodType)
                    .font(.headline)
                Text(foodEvent.building)
                    .font(.subheadline)
                Text(foodEvent.roomNum)
                    .font(.subheadline)
            }
            Spacer()
            
        }
    }
}
