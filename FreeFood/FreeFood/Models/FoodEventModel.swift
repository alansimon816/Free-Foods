//
//  FoodEventModel.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//
import Foundation
import CoreLocation

struct FoodEvent: Codable, Identifiable {
  let id: String
  let dateCreated: Date
  
  let additionalInfo: String
  let building: String
  let foodType: String
  let quantity: String
  let roomNum: String
  
  let UID: String
  let username: String
  
  let landmarkID: UUID
  let name: String
  let address: String
  let latitude: Double
  let longitude: Double
  
  enum CodingKeys: String, CodingKey {
    case id
    case dateCreated
    case foodEvent
    
    enum FoodKeys: String, CodingKey {
      case additionalInfo
      case building
      case foodType
      case quantity
      case roomNum
      case user
      case landmark
    }
    
    enum UserKeys: String, CodingKey {
      case UID
      case username
    }
    
    enum LandmarkKeys: String, CodingKey {
      case landmarkID = "landmark_id"
      case name
      case address
      case coordinate
    }
    
    enum CoordKeys: String, CodingKey {
      case latitude
      case longitude
    }
  }
  
  init(docID: String, date: Date, adtlInfo: String, building: String,
       type: String, quantity: String, roomNo: String,
       UID: String, username: String, landmarkID: UUID,
       name: String, address: String, coord: CLLocationCoordinate2D) {
    self.id = docID
    self.dateCreated = date
    self.additionalInfo = adtlInfo
    self.building = building
    self.foodType = type
    self.quantity = quantity
    self.roomNum = roomNo
    self.UID = UID
    self.username = username
    self.landmarkID = landmarkID
    self.name = name
    self.address = address
    self.latitude = coord.latitude
    self.longitude = coord.longitude
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    
    let event = try container.nestedContainer(keyedBy: CodingKeys.FoodKeys.self,forKey: .foodEvent)
    self.additionalInfo = try event.decode(String.self, forKey: .additionalInfo)
    self.building = try event.decode(String.self, forKey: .building)
    self.roomNum = try event.decode(String.self, forKey: .roomNum)
    self.foodType = try event.decode(String.self, forKey: .foodType)
    self.quantity = try event.decode(String.self, forKey: .quantity)
    
    let user = try event.nestedContainer(keyedBy: CodingKeys.UserKeys.self, forKey: .user)
    self.UID = try user.decode(String.self, forKey: .UID)
    self.username = try user.decode(String.self, forKey: .username)
    
    let landmark = try event.nestedContainer(keyedBy: CodingKeys.LandmarkKeys.self, forKey: .landmark)
    self.landmarkID = try landmark.decode(UUID.self, forKey: .landmarkID)
    self.name = try landmark.decode(String.self, forKey: .name)
    self.address = try landmark.decode(String.self, forKey: .address)
    
    let coordinate = try landmark.nestedContainer(keyedBy: CodingKeys.CoordKeys.self, forKey: .coordinate)
    self.latitude = try coordinate.decode(Double.self, forKey: .latitude)
    self.longitude = try coordinate.decode(Double.self, forKey: .longitude)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(dateCreated, forKey: .dateCreated)
    
    var event = container.nestedContainer(keyedBy: CodingKeys.FoodKeys.self, forKey: .foodEvent)
    try event.encode(additionalInfo, forKey: .additionalInfo)
    try event.encode(building, forKey: .building)
    try event.encode(roomNum, forKey: .roomNum)
    try event.encode(foodType, forKey: .foodType)
    try event.encode(quantity, forKey: .quantity)
    
    var user = event.nestedContainer(keyedBy: CodingKeys.UserKeys.self, forKey: .user)
    try user.encode(UID, forKey: .UID)
    try user.encode(username, forKey: .username)
    
    var landmark = event.nestedContainer(keyedBy: CodingKeys.LandmarkKeys.self, forKey: .landmark)
    try landmark.encode(landmarkID, forKey: .landmarkID)
    try landmark.encode(name, forKey: .name)
    try landmark.encode(address, forKey: .address)
    
    var coordinate = landmark.nestedContainer(keyedBy: CodingKeys.CoordKeys.self, forKey: .coordinate)
    try coordinate.encode(latitude, forKey: .latitude)
    try coordinate.encode(longitude, forKey: .longitude)
  }
}
