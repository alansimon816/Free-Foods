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
  private var authListener: AuthStateDidChangeListenerHandle?
  @Published var signedIn: Bool
  @Published var recentlyRegistered = false
  
  init() {
    signedIn = false
  }
  
  func checkSignStatus() -> Bool {
    authListener = auth.addStateDidChangeListener { (auth, user) in
      if user != nil {
        self.signedIn = true
      } else {
        self.signedIn = false
      }
    }
    return signedIn
  }
  
  func signIn(_ email: String, _ password: String) -> Bool  {
    var signInSuccess: Bool = false
    if checkSignStatus() == false {
      auth.signIn(withEmail: email, password: password) { user, error in
        if let error = error, user == nil {
          print(error.localizedDescription)
        } else {
          signInSuccess = true
        }
      }
    }
    return signInSuccess
  }
  
  func register(_ email: String, _ password: String) -> Bool {
    var success: Bool = false
    if checkSignStatus() == false {
      auth.createUser(withEmail: email, password: password) { user, error in
        if let error = error, user == nil {
          print(error.localizedDescription)
        } else {
            success = true
            self.recentlyRegistered = true
            if !self.signIn(email, password) {
                print("<DEBUG> Unsuccessful sign in after successful sign up")
            }
        }
      }
    }
    return success
  }

    func expireRecentlyRegistered() -> Void {
        self.recentlyRegistered = false
    }
  
  func signOut() {
    if recentlyRegistered {
          // Ensures RegistrationView wont appear again; user has already gone through that workflow
          recentlyRegistered = false
      }
    try? auth.signOut()
  }
}
