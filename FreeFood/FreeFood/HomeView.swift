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
//        Button(action: {
//          print("Hello")
//        }) {
//          ZStack {
//            RoundedRectangle(cornerRadius: 10)
//            Text("Sign In")
//              .foregroundColor(.white)
//          }
//        }.frame(width: 200, height: 50, alignment: .center)
//      }.padding(.top, 50)
//    }




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
  @State var isSignUp: Bool
  @State private var loginFailed = false
  
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
      NavigationLink(destination: AppView()) {
        Text("Submit")
      }.simultaneousGesture(TapGesture().onEnded {
        if isSignUp {
          loginFailed = simpleAuth.register(email, password, repass)
        } else {
          loginFailed = simpleAuth.signIn(email, password)
        }
      })
    }
    .frame(width: 300, height: 300)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environmentObject(SimpleAuthModel())
  }
}
