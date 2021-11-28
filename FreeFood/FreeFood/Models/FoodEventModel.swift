//
//  FoodEventModel.swift
//  FreeFood
//
//  Created by user on 11/28/21.
//
import FirebaseFirestore

struct FoodEvent: Identifiable {
    let additionalInfo: String
    let building: String
    let foodType: String
    let quantity: String
    let roomNum: String
    let UID: String
    let id: String
}
