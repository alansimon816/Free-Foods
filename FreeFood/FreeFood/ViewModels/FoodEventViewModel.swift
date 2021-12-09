//
//  FoodEventViewModel.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//
import Foundation
import FirebaseFirestore
import CoreLocation

// Holds a collection of Food Events
class FoodEventViewModel: ObservableObject {
  @Published var foodEvents = [FoodEvent]()
  private var db = Firestore.firestore()
  
  init() {
    getEvents()
  }
  
  func fetchData(callback: @escaping([FoodEvent]) -> Void ) {
    let ref = db.collection("Food Submissions").order(by: "dateCreated", descending: true)
    ref.addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      
      callback(documents.map { (queryDocumentSnapshot) -> FoodEvent? in
        let event = try? queryDocumentSnapshot.data(as: FoodEvent.self)
        return event
      }.compactMap { $0 })
    }
  }
  
  func getEvents() {
    fetchData(callback: { foodEvents in
      self.foodEvents = foodEvents
    })
  }
}
