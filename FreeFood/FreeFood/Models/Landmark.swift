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
  
  func createPlace() -> Place {
    return Place(id: id, name: name, address: title, coord: coordinate)
  }
}

struct Place: Codable {
  let id: UUID
  let name: String
  let address: String
  var latitude: Double
  var longitude: Double
  
  init(id: UUID, name: String,
       address: String, coord: CLLocationCoordinate2D) {
    self.id = id
    self.name = name
    self.address = address
    self.latitude = coord.latitude
    self.longitude = coord.longitude
  }
  
  enum CodingKeys: String, CodingKey {
    case landmark
    
    enum LandmarkKeys: String, CodingKey {
      case id = "landmark_id"
      case name
      case address
      case coordinate
    }
    
    enum CoordKeys: String, CodingKey {
      case latitude
      case longitude
    }
  }
  
  init(from decoder: Decoder) throws {
    let place = try decoder.container(keyedBy: CodingKeys.self)
    
    let landmark = try place.nestedContainer(keyedBy: CodingKeys.LandmarkKeys.self, forKey: .landmark)
    self.id = try landmark.decode(UUID.self, forKey: .id)
    self.name = try landmark.decode(String.self, forKey: .name)
    self.address = try landmark.decode(String.self, forKey: .address)
    
    let coordinate = try landmark.nestedContainer(keyedBy: CodingKeys.CoordKeys.self, forKey: .coordinate)
    self.latitude = try coordinate.decode(Double.self, forKey: .latitude)
    self.longitude = try coordinate.decode(Double.self, forKey: .longitude)
  }
    
  func encode(to encoder: Encoder) throws {
    var place = encoder.container(keyedBy: CodingKeys.self)
    
    var landmark = place.nestedContainer(keyedBy: CodingKeys.LandmarkKeys.self, forKey: .landmark)
    try landmark.encode(id, forKey: .id)
    try landmark.encode(name, forKey: .name)
    try landmark.encode(address, forKey: .address)
    
    var coordinate = landmark.nestedContainer(keyedBy: CodingKeys.CoordKeys.self, forKey: .coordinate)
    try coordinate.encode(latitude, forKey: .latitude)
    try coordinate.encode(longitude, forKey: .longitude)
  }
}


