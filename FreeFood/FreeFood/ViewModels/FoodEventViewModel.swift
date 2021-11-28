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
    @Published var foodEvents = [FoodEvent]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("Food Submissions").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.foodEvents = documents.map { (queryDocumentSnapshot) -> FoodEvent in
                let data = queryDocumentSnapshot.data()
                
                let additionalInfo = data["Additional Info"] as? String ?? ""
                let building = data["Building"] as? String ?? ""
                let foodType = data["Food Type"] as? String ?? ""
                let quantity = data["Quantity"] as? String ?? ""
                let roomNum = data["Room #"] as? String ?? ""
                let UID = data["UID"] as? String ?? ""
                let id = data.description
                
                return FoodEvent(additionalInfo: additionalInfo, building: building, foodType: foodType, quantity: quantity, roomNum: roomNum, UID: UID, id: id)
            }
        }
    }
}
