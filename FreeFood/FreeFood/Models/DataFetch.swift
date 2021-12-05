//
//  DataFetch.swift
//  FreeFood
//
//  Created by The Final Frontier on 12/5/21.
//

import Foundation
import FirebaseFirestore

class UserDataModel: ObservableObject {
  private var db = Firestore.firestore()
  
  func fetchUsername(UID: String, callback: @escaping (String) -> ()) {
    let usersRef = db.collection("users")
    let query = usersRef.whereField("UID", isEqualTo: UID)
    
    query.getDocuments() {(querySnapshot, err) in
      if err == nil {
        for document in querySnapshot!.documents {
          let docValues = document.data()
          let username = docValues["Username"] as! String
          callback(username)
        }
      }
    }
  }
}
