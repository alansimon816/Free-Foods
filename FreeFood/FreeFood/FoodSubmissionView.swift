//
//  FoodSubmissionView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/15/21.
//

import SwiftUI
import FirebaseFirestore

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
          Button("Submit") {
              storeFoodSubmission(building: loc, roomNum: roomNum, foodType: foodType, quantity: foodSizeOptions[sizeIndex], additionalInfo: infoText)
          }
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

func storeFoodSubmission(building: String, roomNum: String, foodType: String, quantity: String, additionalInfo: String)  {
    let sam = SimpleAuthModel()
    let db = Firestore.firestore()
    var UID = ""
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    
    if let user = sam.auth.currentUser {
        //User is signed in
        UID = user.uid
    } else {
        //No user is signed in
        print("<DEBUG> No user is currently signed in")
    }
    
    ref = db.collection("Food Submissions").addDocument(data: [
        "Building": building,
        "Room #": roomNum,
        "Food Type": foodType,
        "Quantity:": quantity,
        "Additional Info": additionalInfo,
        "UID": UID])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

}
