//
//  SignInModel.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/17/21.
//

import Foundation
import FirebaseAuth

class AuthModel: ObservableObject {
  let auth = Auth.auth()
  @Published var signInSuccess: Bool
  @Published var signedIn: Bool
  
  init() {
    signedIn = false
    signInSuccess = false
  }
  
  func signIn(email: String, password: String) -> Bool  {
    auth.signIn(withEmail: email, password: password) { result, error in
      if result != nil && error == nil {
        self.signInSuccess = true
      }
    }
    return signInSuccess
  }
  
  func register(email: String, password: String) -> Bool {
    var success: Bool = false
    auth.createUser(withEmail: email, password: password) { result, error in
      if result != nil && error == nil {
        success = true
      }
    }
    return success
  }
  
  
  
}
