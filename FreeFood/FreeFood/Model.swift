//
//  Model.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import Foundation

class Model: ObservableObject {
    var users: [User] = []
    var login: Login = Login()  // the current login
    static var userId = 0 // Do not directly reference this; access through generateUserId()
    
    static func generateUserId() -> Int {
        userId += 1
        return userId - 1
    }
}

class Login {
}


// in case we need to throw any errors: throw MyError("My error msg")
enum MyError: Error {
    case runtimeError(String)
}

class User: Identifiable {
    var firstName: String = ""
    var lastName: String = ""
    var dob: String // mm/dd/yyyy format. assumption is we limit user dob selection to 3 Picker views
    var settings = Dictionary<String, Bool>() // ie settings["NotifyWhenFriendsPost"] = true
    var score = 0
    var id: Int = Model.generateUserId()
    
    init(first: String, last: String, dob: [Int]) {
        firstName = first
        lastName = last
        self.dob = "\(dob[0])\\\(dob[1])\\\(dob[2])"
    }
}

enum Food: String, CaseIterable {
    case american = "American"
    case asian = "Asian"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case italian = "Italian"
    case desserts = "Desserts"
    case lunch = "Lunch"
    case breakfast = "Breakfast"
    case snacks = "Snacks"
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case keto = "Keto"
}

func getFoods() -> [String] {
    var foods: [String] = []
    
    for food in Food.allCases {
        foods += [food.rawValue]
    }
    
    return foods.sorted()
}
