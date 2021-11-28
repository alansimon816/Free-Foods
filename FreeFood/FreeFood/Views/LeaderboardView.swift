//
//  LeaderboardView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import Foundation
import SwiftUI

struct LeaderboardView: View {
  @EnvironmentObject var model: Model
  
  // Make this a navigation View, navigation link takes you to user's summary page
  var body: some View {
    List {
      ForEach(model.users.sorted(by: {$0.score < $1.score})) { user in
        NavigationLink {
          UserSummaryView(user)
        } label: {
          UserItemView(user)
        }
      }
    }
  }
}

// Leaderboard list item view for a user
struct UserItemView: View {
    var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            // Insert Profile Pic Cropped into a circle
            Spacer()
            Text(user.firstName + " " + user.lastName)
            Spacer()
            Text(String(user.score))
        }
    }
}

// Detailed view of a user
struct UserSummaryView: View {
    var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
        }
    }
}
