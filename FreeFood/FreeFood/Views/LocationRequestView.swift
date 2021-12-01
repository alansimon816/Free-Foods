//
//  LocationRequestView.swift
//  FreeFood
//
//  Created by user on 11/27/21.
//

import SwiftUI



// IGNORE THIS FILE FOR NOW


struct LocationRequestView: View {
  @ObservedObject var lm = LocationManager.shared
  @State var showAppView = false
  
  var body: some View {
      if showAppView {
          AppView()
      } else {
          ZStack {
            Color.green.ignoresSafeArea()
            
            VStack {
              Spacer()
              
              Image(systemName: "paperplane.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width:180, height: 180)
                .padding(.bottom, 35)
              
              Text("Share your location to best experience FreeFoods").foregroundColor(.black)
                .padding()
              
              Spacer()
              
//              NavigationLink(destination: AppView()) {
//                Text("Share Location")
//              }.simultaneousGesture(TapGesture().onEnded {
//                //LocationManager.shared.requestLocation()
//                lm.requestLocation()
//              })
//              NavigationLink(destination: AppView()) {
//                Text("Skip")
//              }
              
              Button {
                  print("Share location button pressed")
                  if lm.userLocation == nil {
                      print("\n\nUser location is nil\n\n")
                      lm.requestLocation()
                  } else {
                      print("\n\nUser location present\n\n")
                      self.showAppView = true
                  }
              } label: {
                  Text("Share Location")
                      .foregroundColor(.green)
                      .padding()
              }
              .background(Color.black)
              .clipShape(Capsule())

              Button {
                  self.showAppView = true
              } label: {
                  Text("Skip")
                      .foregroundColor(.green)
                      .padding()
              }
              .background(Color.black)
              .clipShape(Capsule())
            }
          }
      }
  }
}
