//
//  LocationManager.swift
//  FreeFood
//
//  Created by user on 11/27/21.
//

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.9875,
                                                                                   longitude: -76.9393),
                                                    span: MKCoordinateSpan(latitudeDelta: 0.01 ,
                                                                           longitudeDelta: 0.01))
  @Published var userLocation: CLLocation? = nil
  private let lm = CLLocationManager()
  static let shared = LocationManager() // Accessible anywhere in app
  
  // Standard location stuff
  override init() {
    super.init()
    lm.delegate = self
    lm.desiredAccuracy = kCLLocationAccuracyBest
    lm.distanceFilter = 4
    lm.requestWhenInUseAuthorization()
    lm.startUpdatingLocation()
  }
  
  func requestLocation() {
    lm.requestWhenInUseAuthorization() // only requests location when app is in use
  }
  
  // Manages the different possible location authorization statuses.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
      case .notDetermined:
        print("<DEBUG> Not determined")
      case .restricted:
        print("<DEBUG> Restricted")
      case .denied:
        print("<DEBUG> Denied")
      case .authorizedAlways:
        print("<DEBUG> Authorized Always")
      case .authorizedWhenInUse:
        print("<DEBUG> Authorized When In Use")
      @unknown default:
        break
    }
  }
  
  // used after user has agreed to share their location
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let loc = locations.last else { return }
    self.userLocation = loc
  }
}
