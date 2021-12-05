//
//  FoodEventViewModel.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//
import Foundation
import FirebaseFirestore

// Holds a collection of Food Events
class FoodEventViewModel: ObservableObject {
  var events = [FoodEvent?]()
  @Published var foodEvents = [FoodEvent]()
  
  private var db = Firestore.firestore()
  
  func fetchData() {
    let ref = db.collection("Food Submissions").order(by: "dateCreated", descending: true)
    ref.addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      
      self.events = documents.map { (queryDocumentSnapshot) -> FoodEvent? in
        let event = try? queryDocumentSnapshot.data(as: FoodEvent.self)
        return event
      }
    }
    foodEvents = events.compactMap { $0 }
  }
  
}
