//
//  FoodSubmissionView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/15/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit

struct FoodSubmissionView: View {
  @ObservedObject var viewModel = FoodEventViewModel()
  @Binding var showSubmission: Bool
  @State var loc = ""
  @State var roomNum = ""
  @State var foodType = ""
  @State var placeholderText = "Enter more details about food available, for example, 10 boxes of Subway sandwiches available"
  @State var infoText = "Enter more details about food available, for example, 10 boxes of Subway sandwiches available"
  @State private var sizeIndex = 0
  @State private var foodError: FoodFormError?
  @State private var incomplete = false
  @State var search = ""
  @State var landmark: Landmark?
  var username: String = ""
  
  var foodSizeOptions = ["A Few (1 - 5 servings)",
                         "A Decent Amount (6 - 15 servings)",
                         "We Ordered Too Much (16+ servings)"]
  
  public func dismiss() {
    if !incomplete {
      storeFoodSubmission(landmark: landmark!,
                          building: loc,
                          roomNum: roomNum,
                          foodType: foodType,
                          quantity: foodSizeOptions[sizeIndex],
                          additionalInfo: infoText)
      showSubmission = false
    }
  }
  
  public func storeFoodSubmission(landmark: Landmark, building: String, roomNum: String,
                                  foodType: String, quantity: String, additionalInfo: String)  {
    let sam = SimpleAuthModel()
    let db = Firestore.firestore()
    let udm = UserDataModel()
    var UID = ""
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    
    if let user = sam.auth.currentUser {
      //User is signed in
      UID = user.uid
    } else {
      //No user is signed in
      print("<DEBUG> No user is currently signed in")
      return
    }
    
    udm.fetchUsername(UID: UID, callback: { (resultString) in
      ref = db.collection("Food Submissions").document()
      
      let docID = ref!.documentID
      let date = Date.now
      let event = FoodEvent(docID: docID, date: date, adtlInfo: additionalInfo, building: building,
                            type: foodType, quantity: quantity, roomNo: roomNum,
                            UID: UID, username: resultString, landmarkID: landmark.id,
                            name: landmark.name, address: landmark.title, coord: landmark.coordinate)
      
      do {
        try db.collection("Food Submissions").document(docID).setData(from: event)
      } catch let error {
        print("Error writing to Firestore: \(error)")
      }
    })
  }

  var body: some View {
    VStack {
      Form {
        Section(header: Text("LOCATION")) {
          LocationSearchView(search: $search, landmark: $landmark)
          TextField("Building Name", text: $loc)
            .onTapGesture() {
              if landmark != nil && loc == "" {
                loc = landmark!.name
              }
            }
          TextField("Room #", text: $roomNum)
        }.disableAutocorrection(true)
        
        Section(header: Text("FOOD INFORMATION")) {
          TextField("Restaurant (ex. Subway)", text: $foodType)
          Picker(selection: $sizeIndex, label: Text("Food Amount")) {
            ForEach(self.foodSizeOptions.indices, id: \.self) {
              Text(self.foodSizeOptions[$0])
            }
          }
        }
        
        Section(header: Text("ADDITIONAL INFO")) {
          TextEditor(text: $infoText)
            .foregroundColor(infoText == placeholderText ? .gray : .primary)
            .submitLabel(.done)
            .onTapGesture {
              if infoText == placeholderText {
                infoText = ""
              } else if infoText == "" {
                infoText = placeholderText
              }
            }
        }
        
        Section {
          Button(action: {
            if loc == "" || landmark == nil {
              incomplete = true
              foodError = .buildingMissing
            }
            
            if roomNum == "" {
              incomplete = true
              foodError = .roomNoMissing
            }
            
            if foodType == "" {
              incomplete = true
              foodError = .restaurantMissing
            }
            
            infoText = (infoText == placeholderText ? "" : infoText)
            self.dismiss()
          }) {
            Text("Submit").padding(.horizontal, 10)
          }.alert(isPresented: $incomplete) {
            Alert(title: Text(foodError!.rawValue),
                  message: Text("Please enter the missing information."),
                  dismissButton: .default(Text("OK")))
          }
          Button(role: .destructive, action: {
            showSubmission = false
          }) {
            Text("Cancel").padding(.horizontal, 10)
          }
        }
      }
    }.navigationBarTitle(Text("Food Submission"))
  }
}

enum FoodFormError: String {
  case buildingMissing = "Building Missing"
  case roomNoMissing = "Room No. Missing"
  case restaurantMissing = "Restaurant Missing"
}

struct FoodSubmissionView_Previews: PreviewProvider {
  static var previews: some View {
    FoodSubmissionView(showSubmission: .constant(true))
  }
}
