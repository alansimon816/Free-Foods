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
  
  init() {
    vm.getLocations()
  }
  
  var body: some View {
    Map(coordinateRegion: $lm.region,
        interactionModes: .all,
        showsUserLocation: true,
        userTrackingMode: .constant(.follow),
        annotationItems: vm.eventLocations) {
      MapAnnotation(coordinate: $0) {
        Circle()
          .size(CGSize(width: 15, height: 15))
          .fill(Color.red)
      }
    }
  }
}

struct FoodMapView: View {
  @EnvironmentObject var lm: LocationManager
  @ObservedObject var viewModel = FoodEventViewModel()
  
  var body: some View {
    ZStack(alignment: .top) {
      MapView()
    }.navigationTitle("Food Map")
  }
}

extension CLLocationCoordinate2D: Identifiable {
  public var id: String {
    "\(latitude), \(longitude)"
  }
}


















