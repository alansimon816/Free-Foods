//
//  FoodSubmissionView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/15/21.
//

import SwiftUI

struct FoodSubmissionView: View {
  @State var loc = ""
  @State var roomNum = ""
  @State var foodType = ""
  @State var infoText = "Enter more details about the food available, for example, 10 boxes of Subway sandwiches available"
  @State private var sizeIndex = 0
  var foodSizeOptions = ["A Few (1 - 5 servings)",
                         "A Decent Amount (6 - 15 servings)",
                         "We Ordered Too Much (16+ servings)"]
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("LOCATION")) {
          TextField("Building", text: $loc)
          TextField("Room Number", text: $roomNum)
        }
        
        Section(header: Text("FOOD INFORMATION")) {
          TextField("Type (ex. Subways)", text: $foodType)
          Picker(selection: $sizeIndex, label: Text("Food Amount")) {
            ForEach(0..<foodSizeOptions.count) {
              Text(self.foodSizeOptions[$0])
            }
          }
        }
        
        Section(header: Text("ADDITIONAL INFO")) {
          TextEditor(text: $infoText)
            .foregroundColor(.secondary)
            .submitLabel(.done)
        }
        
        Section() {
          Button("Submit") {}
          Button("Cancel") {}
        }
      }.navigationBarTitle(Text("Food Submission"))
    }
  }
}

struct FoodSubmissionView_Previews: PreviewProvider {
  static var previews: some View {
    FoodSubmissionView()
  }
}
