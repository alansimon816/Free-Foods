//
//  LocationRequestView.swift
//  FreeFood
//
//  Created by user on 11/27/21.
//

import SwiftUI

struct LocationRequestView: View {
  @ObservedObject var lm = LocationManager.shared
  
  var body: some View {
    ZStack {
      Color.green.ignoresSafeArea()
      
      VStack {
        Spacer()
        
        Image(systemName: "paperplane.circle.fill")
          .resizable()
          .scaledToFit()
          .frame(width:180, height: 180)
          .padding(.bottom, 35)
        
        Text("Share your location to experience FreeFoods").foregroundColor(.black)
          .padding()
        
        Spacer()
        
        NavigationLink(destination: AppView()) {
          Text("Share Location")
        }.simultaneousGesture(TapGesture().onEnded {
          //LocationManager.shared.requestLocation()
          lm.requestLocation()
        })
        NavigationLink(destination: AppView()) {
          Text("Skip")
        }
        
        //                    Button {
        //                        LocationManager.shared.requestLocation()
        //                    } label: {
        //                        Text("Share Location")
        //                            .foregroundColor(.green)
        //                            .padding()
        //                    }
        //                    .background(Color.black)
        //                    .clipShape(Capsule())
        //
        //                    Button {
        //                    } label: {
        //                        Text("Skip")
        //                            .foregroundColor(.green)
        //                            .padding()
        //                    }
        //                    .background(Color.black)
        //                    .clipShape(Capsule())
      }
    }
  }
}
