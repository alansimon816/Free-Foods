//
//  FoodMapView.swift
//  FreeFood
//
//  Created by user on 11/30/21.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
  @ObservedObject var lm = LocationManager()
  @ObservedObject var vm = FoodEventViewModel()
  @State var showInfo = false
  
  var body: some View {
    Map(coordinateRegion: $lm.region,
        interactionModes: .all,
        showsUserLocation: false,
        userTrackingMode: .constant(.follow),
        annotationItems: vm.foodEvents) { event in
      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: event.latitude,
                                                       longitude: event.longitude)) {
          Image(systemName: "mappin.square.fill")
            .foregroundColor(Color("BlueSapphire"))
            .frame(width: 15, height: 15)
      }
    }
  }
}

struct FoodMapView: View {
  @EnvironmentObject var lm: LocationManager
  @ObservedObject var viewModel = FoodEventViewModel()
  
  var body: some View {
    ZStack(alignment: .top) {
      MapView().onAppear {
        viewModel.getEvents()
      }
    }.navigationTitle("Food Map")
  }
}

extension CLLocationCoordinate2D: Identifiable {
  public var id: String {
    "\(latitude), \(longitude)"
  }
}


















