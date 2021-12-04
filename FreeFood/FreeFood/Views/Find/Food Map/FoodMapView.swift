//
//  FoodMapView.swift
//  FreeFood
//
//  Created by user on 11/30/21.
//

import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
  @ObservedObject var lm = LocationManager.shared
  var control: MapView
  
  init(_ control: MapView) {
    self.control = control
  }
  
  func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
    if let annotationView = views.first {
      if let annotation = annotationView.annotation {
        if annotation is MKUserLocation {
          let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
          mapView.setRegion(region, animated: true)
        }
      }
    }
  }
}

struct MapView: UIViewRepresentable {
  
  let landmarks: [Landmark]
  
  func makeUIView(context: Context) -> MKMapView {
    let map = MKMapView()
    map.showsUserLocation = true
    map.delegate = context.coordinator //coordinator processes functions for the map view
    
    let region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 38.9875, longitude: -76.9393),
      span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    map.setRegion(region, animated: true)
    
    return map
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    //updateAnnotations(from: uiView)
  }
  
  // Need to create a separate property in the MapView struct for Food Submission landmarks and then update the map with those landmarks in this method
  private func updateAnnotations(from mapView: MKMapView) {
    mapView.removeAnnotations(mapView.annotations)
    let annotations = self.landmarks.map(LandmarkAnnotation.init)
    mapView.addAnnotations(annotations)
  }
}

struct FoodMapView: View {
  @ObservedObject var lm = LocationManager.shared
  @State private var search = ""
  @State private var landmarks = [Landmark]()
  @State private var tapped = false
  
  var body: some View {
    ZStack(alignment: .top) {
      MapView(landmarks: landmarks)
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
    
    let search = MKLocalSearch(request: request)
    search.start { (response, error) in
      if let response = response {
        let mapItems = response.mapItems
        self.landmarks = mapItems.map {
          Landmark(placemark: $0.placemark)
        }
      }
    }
  }
}


















