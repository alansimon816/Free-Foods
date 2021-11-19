//
//  SignInModel.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/17/21.
//

import Foundation
import FirebaseAuth

class SimpleAuthModel: ObservableObject {
  let auth = Auth.auth()
  @Published var signInSuccess: Bool
  @Published var signedIn: Bool
  
  init() {
    signedIn = false
    signInSuccess = false
  }
  
  func signIn(_ email: String, _ password: String) -> Bool  {
    auth.signIn(withEmail: email, password: password) { result, error in
      if result != nil && error == nil {
        self.signInSuccess = true
      }
    }
    return signInSuccess
  }
  
  func register(_ email: String, _ password: String, _ repass: String) -> Bool {
    var success: Bool = false
    if password == repass {
      auth.createUser(withEmail: email, password: password) { result, error in
        if result != nil && error == nil {
          success = true
        }
      }
      return success
    } else {
      return success
    }
  }
}
