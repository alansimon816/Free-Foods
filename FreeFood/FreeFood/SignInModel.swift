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
  var userStatusListenerHandle: AuthStateDidChangeListenerHandle?
  enum userStatus {
    case undefined, signedIn, signedOut
  }
  @Published var userState: userStatus = .undefined
  @Published var recentlyRegistered = false
  
  func didUserStatusChange() {
    userStatusListenerHandle = auth.addStateDidChangeListener({ (_, user) in
      guard user != nil else {
        self.userState = .signedOut
        return
      }
      self.userState = .signedIn
    })
  }
  
  func signIn(_ email: String, _ password: String, callback: @escaping (Result<Bool, Error>) -> ()) {
    if userState == .signedOut || userState == .undefined {
      auth.signIn(withEmail: email, password: password) { (user, error) in
        if let err = error {
          callback(.failure(err))
        } else {
          callback(.success(true))
        }
      }
    }
  }
  
  func register(_ email: String, _ password: String, callback: @escaping(Result<Bool, Error>) -> ()) {
    
    if userState == .signedOut || userState == .undefined {
      auth.createUser(withEmail: email, password: password) { user, error in
        if let err = error {
          callback(.failure(err))
        } else {
          self.recentlyRegistered = true
          callback(.success(true))
          
          // Not sure if this works because signIn can't happen when a user has already signed up
          //          if !self.signIn(email, password) {
          //              print("<DEBUG> Unsuccessful sign in after successful sign up")
          //          }
        }
      }
    }
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
 
