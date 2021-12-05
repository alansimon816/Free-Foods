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
  @EnvironmentObject var lm: LocationManager
  @ObservedObject var viewModel = FoodEventViewModel()
  @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.9875,
                                                                        longitude: -76.9393),
                                         span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                                longitudeDelta: 0.005))
  var body: some View {
    
    Map(coordinateRegion: $region,
        interactionModes: .all,
        showsUserLocation: true,
        userTrackingMode: .constant(.follow),
        annotationItems: viewModel.foodEvents) {
      MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude),
                tint: Color("LaurelGreen"))
    }
  }
}

struct FoodMapView: View {
  @ObservedObject var lm = LocationManager.shared
  @State private var search = ""
  @State private var landmarks = [Landmark]()
  @State private var tapped = false
  
  var body: some View {
    ZStack(alignment: .top) {
      MapView()
      TextField("Search", text: $search, onEditingChanged: {_ in}) {
        self.getNearByLandmarks()
      }   .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .offset(y: 35)
      ListPlacesView(landmarks: self.landmarks, showResults: $tapped) {
        self.tapped.toggle()
      }.animation(.spring())
        .offset(y: calcOffset())
    }.navigationTitle("Food Map")
  }
  
  func calcOffset() -> CGFloat {
    if self.landmarks.count > 0 && !self.tapped {
      return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
    } else if self.tapped {
      return 100
    } else {
      return UIScreen.main.bounds.size.height
    }
  }
  
  // use this
  private func getNearByLandmarks() {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = search
    request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.9875,
                                                                       longitude: -76.9393),
                                        span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                               longitudeDelta: 0.005))
    let search = MKLocalSearch(request: request)
    search.start { (response, error) in
      if let response = response {
        let mapItems = response.mapItems.filter {
          $0.placemark.locality == "College Park"
        }
        self.landmarks = mapItems.map {
          return Landmark(placemark: $0.placemark)
        }
      }
    }
  }
}


















