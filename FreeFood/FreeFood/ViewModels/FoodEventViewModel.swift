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
  @Published var eventLocations = [CLLocationCoordinate2D]()
  private var db = Firestore.firestore()
  var events = [FoodEvent?]()
  
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
  
  func getLocations() {
    fetchData()
    for event in foodEvents {
      let coord = CLLocationCoordinate2D(latitude: event.latitude,
                                         longitude: event.longitude)
      eventLocations.append(coord)
    }
  }
}
