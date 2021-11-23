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
  @Published var signedIn: Bool
  
  init() {
    signedIn = false
  }
  
  func checkSignStatus() -> Bool {
    signOut()
    if auth.currentUser != nil {
      signedIn = true
    } else {
      signedIn = false
    }
    return signedIn
  }
  
  func signIn(_ email: String, _ password: String) -> Bool  {
    var signInSuccess: Bool = false
    if !checkSignStatus() {
      auth.signIn(withEmail: email, password: password) { result, error in
        if result != nil && error == nil {
          signInSuccess = true
        } else {
          
        }
      }
    }
    return signInSuccess
  }
  
  func register(_ email: String, _ password: String, _ repass: String) -> Bool {
    print("Here")
    var success: Bool = false
    print(checkSignStatus())
    if checkSignStatus() == false {
      print("Here")
      if password == repass {
        auth.createUser(withEmail: email, password: password) { result, error in
          if result != nil && error == nil {
            success = true
          } else {
            print("Error: " )
            print(error as Any)
            print()
            print()
          }
        }
      } else {
        print()
        print("Incorrect Password")
        print()
      }
    } else {
      print("Sign in unsuccessful")
    }
    return success
  }
  
  func signOut() {
    try? auth.signOut()
  }
}
