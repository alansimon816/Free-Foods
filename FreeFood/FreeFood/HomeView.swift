//
//  HomeView.swift
//  FreeFood
//
//  Created by The Final Frontier on 11/18/21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
  @State var showSignUp = false
  @State var showSignIn = false
  
  var body: some View {
    NavigationView {
      VStack {
        Image("logo")
          .resizable()
          .scaledToFit()
          .frame(width: 300, height: 300)
          .clipShape(Circle())
          .padding(.bottom, 100)
        NavigationLink(destination: SimpleLoginView(true), isActive: $showSignUp) {
          Text("Sign Up")
            .foregroundColor(.white)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 50)
            )
        }
        .offset(x: 0, y: -50)
        NavigationLink(destination: SimpleLoginView(false), isActive: $showSignIn) {
          Text("Sign In")
            .foregroundColor(.white)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 50)
            )
        }
      }
    }
  }
}

struct LogOutButton: View {
  @EnvironmentObject var simpleAuth: SimpleAuthModel
  var body: some View {
    
    NavigationLink(destination: HomeView().navigationBarHidden(true)) {
      Text("Sign Out")
    }.simultaneousGesture(TapGesture().onEnded {
      simpleAuth.signOut()
    })
    
  }
}

struct SimpleLoginView: View {
  @EnvironmentObject var simpleAuth: SimpleAuthModel
  @State private var email = ""
  @State private var password = ""
  @State private var repass = ""
  @State private var isSecured = true
  @State private var isConfirmedSecured = true
  @State private var errorInfo: AuthErrorInfo?
  @State private var loginSuccess = false
  @State var isSignUp: Bool
  
  init(_ showUp: Bool) {
    isSignUp = showUp
  }
  
  var body: some View {
    VStack {
      TextField("Email", text: self.$email)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .textFieldStyle(.roundedBorder)
      VStack {
        if isSignUp {
          // user doesn't have an existing account
          ZStack(alignment: .trailing) {
            if isSecured {
              SecureField("Password", text: $password)
            } else {
              TextField("Password", text: $password)
            }
            Button(action: {
              isSecured.toggle()
            }) {
              Image(systemName: self.isSecured ? "eye.slash" : "eye")
                .accentColor(.gray)
            }
          }
          
          ZStack(alignment: .trailing) {
            if isConfirmedSecured {
              SecureField("Confirm Password", text: $repass)
            } else {
              TextField("Confirm Password", text: $repass)
            }
            Button(action: {
              isConfirmedSecured.toggle()
            }) {
              Image(systemName: self.isConfirmedSecured ? "eye.slash" : "eye")
                .accentColor(.gray)
            }
          }
        } else {
          // user has an existing account
          ZStack(alignment: .trailing) {
            if isSecured {
              SecureField("Enter Password", text: $password)
            } else {
              TextField("Enter Password", text: $password)
            }
            Button(action: {
              isSecured.toggle()
            }) {
              Image(systemName: self.isSecured ? "eye.slash" : "eye")
                .accentColor(.gray)
            }
          }
        }
      }
      .autocapitalization(.none)
      .textFieldStyle(.roundedBorder)
      .disableAutocorrection(true)
      NavigationLink(destination: AppView(), isActive: $loginSuccess) {
        Text("Submit")
      }.simultaneousGesture(TapGesture().onEnded {
        if isSignUp {
          if password.count > 6 {
            if password == repass {
              loginSuccess = simpleAuth.register(email, password)
            } else {
              errorInfo = AuthErrorInfo(id: .passwordMismatch,
                                        title: "Unable to Login",
                                        message:
                                          """
                                          The passwords did not match.
                                          Please try again.
                                          """)

            }
          } else {
            errorInfo = AuthErrorInfo(id: .passwordTooShort,
                                      title: "Unable to Sign Up",
                                      message:
                                        """
                                        The password entered was too short.
                                        Passwords must be 6 characters or longer.
                                        Please try again.
                                        """)
          }
        } else {
          loginSuccess = simpleAuth.signIn(email, password)
          if !loginSuccess {
            errorInfo = AuthErrorInfo(id: .accountMismatch,
                                      title: "Unable to Login",
                                      message:
                                        """
                                        An account may not be associated with this email.
                                        Or the password entered was incorrect.
                                        Please try again.
                                        """)
          }
        }
      }).alert(item: $errorInfo, content: { errorInfo in
        Alert(title: Text(errorInfo.title),
              message: Text(errorInfo.message),
              dismissButton: .default(Text("Close"), action: {
                if isSignUp {
                  email = ""
                  password = ""
                  repass = ""
                } else {
                  password = ""
                }
        }))
      })
    }
    .frame(width: 300, height: 300)
  }
}

struct AuthErrorInfo: Identifiable {
  enum AuthErrorType {
    case passwordMismatch
    case passwordTooShort
    case accountMismatch
  }
  
  let id: AuthErrorType
  let title: String
  let message: String
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environmentObject(SimpleAuthModel())
  }
}
