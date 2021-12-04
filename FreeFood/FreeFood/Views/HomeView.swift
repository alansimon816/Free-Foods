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
        NavigationLink(destination: SimpleRegisterView(), isActive: $showSignUp) {
          Text("Sign Up")
            .foregroundColor(.white)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 50)
            )
        }
        .offset(x: 0, y: -50)
        NavigationLink(destination: SimpleLoginView(), isActive: $showSignIn) {
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
  @EnvironmentObject var sam: SimpleAuthModel
  var body: some View {
    NavigationLink(destination: HomeView().navigationBarHidden(true)) {
      Text("Sign Out")
    }.simultaneousGesture(TapGesture().onEnded {
      sam.signOut()
    })
  }
}

struct SimpleRegisterView: View {
  @EnvironmentObject var sam: SimpleAuthModel
  @State private var email = ""
  @State private var password = ""
  @State private var repass = ""
  @State private var isSecured = true
  @State private var isConfirmedSecured = true
  @State private var errorInfo: AuthErrorInfo?
  @State private var didError: Bool = false
  @State private var isRegistered: Bool = false
  
  var body: some View {
    VStack {
      VStack {
        TextField("Email", text: self.$email)
          .textContentType(.emailAddress)
          .keyboardType(.emailAddress)
          .autocapitalization(.none)
        ZStack(alignment: .trailing) {
          if isSecured {
            SecureField("Password", text: $password)
              .textContentType(.none)
          } else {
            TextField("Password", text: $password)
              .textContentType(.none)
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
              .textContentType(.none)
          } else {
            TextField("Confirm Password", text: $repass)
              .textContentType(.none)
          }
          
          Button(action: {
            isConfirmedSecured.toggle()
          }) {
            Image(systemName: self.isConfirmedSecured ? "eye.slash" : "eye")
              .accentColor(.gray)
          }
        }
      }
      .autocapitalization(.none)
      .textFieldStyle(.roundedBorder)
      .disableAutocorrection(true)
      .frame(width: 300, height: 200, alignment: .center)
      VStack {
        NavigationLink(destination: RegistrationView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle(Text("Registration")),
                       isActive: $isRegistered) {
          EmptyView()
        }
        Button(action: {
          if password.count > 6 {
            if password == repass {
              sam.register(email, password) { result in
                switch result {
                  case .failure(let error):
                    errorInfo = AuthErrorInfo(id: .otherError,
                                              message: error.localizedDescription)
                    
                    print("<DEBUG> Sign up unsuccessful")
                    print(error.localizedDescription)
                    print()
                    didError = true
                  case .success(_ ):
                    print("<DEBUG> Sign up successful")
                    print()
                    isRegistered = true
                }
              }
            } else {
              errorInfo = AuthErrorInfo(id: .passwordMismatch,
                                        message:
                                            """
                                            The passwords did not match.
                                            Please try again.
                                            """)
              didError = true
            }
          } else {
            errorInfo = AuthErrorInfo(id: .passwordTooShort,
                                      message:
                                          """
                                          The password entered was too short.
                                          Passwords must be 6 characters or longer.
                                          Please try again.
                                          """)
            didError = true
          }
        }) {
          Text("Submit")
            .foregroundColor(.white)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 50)
            )
        }
        .alert(isPresented: $didError) {
          Alert(title: Text("An error has occurred"),
                message: Text(errorInfo!.message),
                dismissButton: .default(Text("Close"), action: {
            isRegistered = false
            email = ""
            password = ""
            repass = ""
          }))
        }
      }
    }
  }
}

struct SimpleLoginView: View {
  @EnvironmentObject var sam: SimpleAuthModel
  @State private var email = ""
  @State private var password = ""
  @State private var repass = ""
  @State private var isSecured = true
  @State private var errorInfo: AuthErrorInfo?
  @State private var loginSuccess = false
  @State private var didError = false
  
  var body: some View {
    VStack {
      VStack {
        TextField("Email", text: self.$email)
          .textContentType(.emailAddress)
          .keyboardType(.emailAddress)
          .autocapitalization(.none)
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
      .autocapitalization(.none)
      .textFieldStyle(.roundedBorder)
      .disableAutocorrection(true)
      .frame(width: 300, height: 200, alignment: .center)
      
      VStack {
        NavigationLink(destination: AppView(), isActive: $loginSuccess) {
          EmptyView()
        }
        Button(action: {
          sam.signIn(email, password) { result in
            switch result {
              case .failure(let error):
                errorInfo = AuthErrorInfo(id: .otherError,
                                          message: error.localizedDescription)
                print("<DEBUG> Sign in unsuccessful")
                print(error.localizedDescription)
                print()
                didError = true
                loginSuccess = false
              case .success(_ ):
                loginSuccess = true
                didError = false
                print("<DEBUG> Sign in successful")
                print()
            }
          }
        }) {
          Text("Submit")
            .foregroundColor(.white)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 50)
            )
        }
        .padding(.bottom, 100)
        .alert(isPresented: $didError) {
          Alert(title: Text("An error has occurred"),
                message: Text(errorInfo!.message),
                dismissButton: .default(Text("Close"), action: {
            loginSuccess = false
            email = ""
            password = ""
          }))
        }
      }
    }
  }
}

struct AuthErrorInfo: Identifiable {
  enum AuthErrorType {
    case passwordMismatch
    case passwordTooShort
    case accountMismatch
    case otherError
  }
  
  let id: AuthErrorType
  let message: String
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environmentObject(SimpleAuthModel())
  }
}
