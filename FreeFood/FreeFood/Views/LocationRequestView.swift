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
                NavigationView {
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
                    
<<<<<<< HEAD:FreeFood/FreeFood/LocationRequestView.swift
                          NavigationLink(destination: LaunchView(recentRegister: false)) {
=======
                            NavigationLink(destination: LaunchView(recentRegister: false)) {
>>>>>>> 3f5312d766423d4575ff3d2b9378a2a6365dab00:FreeFood/FreeFood/Views/LocationRequestView.swift
                            Text("Share Location")
                        }.simultaneousGesture(TapGesture().onEnded {
                            //LocationManager.shared.requestLocation()
                            lm.requestLocation()
                        })
<<<<<<< HEAD:FreeFood/FreeFood/LocationRequestView.swift
                          NavigationLink(destination: LaunchView(recentRegister: false)) {
=======
                            NavigationLink(destination: LaunchView(recentRegister: false)) {
>>>>>>> 3f5312d766423d4575ff3d2b9378a2a6365dab00:FreeFood/FreeFood/Views/LocationRequestView.swift
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
}
