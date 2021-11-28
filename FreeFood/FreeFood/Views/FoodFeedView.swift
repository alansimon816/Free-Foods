//
//  FoodFeedView.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//
import SwiftUI

struct FoodFeedView: View {
    @ObservedObject private var viewModel = FoodEventViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.foodEvents) { foodEvent in
                NavigationLink(destination: FoodEventView(foodEvent: foodEvent)) {
                    FoodFeedItemView(foodEvent)
                }
            }
            .onAppear() {
                self.viewModel.fetchData()
            }
        }
    }
}
