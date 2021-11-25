//
//  RegistrationView.swift
//  FreeFood
//
//  Created by user on 11/24/21.
//

import Foundation
import SwiftUI

// This view is to be presented directly after a user successfully signs up
struct RegistrationView: View {
    @State var username = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var favFoodTypes: [Food] = []
    
    var body: some View {
        NavigationView {
          Form {
          Section(header: Text("USERNAME")) {
            TextField("Username", text: $username)
          }
            Section(header: Text("NAME")) {
              TextField("First", text: $firstName)
              TextField("Last", text: $lastName)
            }
              Section(header: Text("FAVORITE FOODS")) {
                SelectMultipleList()
            }
            Section() {
              Button("Submit") {}
            }
          }.navigationBarTitle(Text("User Registration"))
        }
    }
}

struct FoodRow: View {
    var food: String
    var selected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(food)
                if self.selected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct SelectMultipleList: View {
    @State var selectedFoods: [String] = []
    @State var foods: [String] = getFoods()

    var body: some View {
        List {
            ForEach(self.foods, id: \.self) { food in
                FoodRow(food: food, selected: self.selectedFoods.contains(food)) {
                    if self.selectedFoods.contains(food) {
                        self.selectedFoods.removeAll(where: { $0 == food })
                    }
                    else {
                        self.selectedFoods.append(food)
                    }
                }
            }
        }
    }
}
