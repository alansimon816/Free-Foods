//
//  Landmark.swift
//  FreeFood
//
//  Created by user on 11/30/21.
//

import Foundation
import MapKit

// idea is to create a landmark for each food submission
struct Landmark {
  let placemark: MKPlacemark
  
  var id: UUID {
    return UUID()
  }
  
  var name: String {
    self.placemark.name ?? ""
  }
  
  var title: String {
    self.placemark.title ?? ""
  }
  
  var coordinate: CLLocationCoordinate2D {
    self.placemark.coordinate
  }
}


