//
//  AccountView.swift
//  FreeFood
//
//  Created by user on 11/7/21.
//

import Foundation
import SwiftUI

// User's account settings
struct AccountView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle").scaleEffect(8).padding(100)
            Divider()
            NavigationLink(destination: SubmissionHistoryView()) {
                HStack {
                    Image(systemName: "clock")
                    Text("Food Submission History")
                      //.navigationBarHidden(true)
                    Spacer()
                }
            }
            Divider()
            NavigationLink(destination: EditAccountView()) {
                HStack {
                    Image(systemName: "pencil")
                    Text("Edit Account Details")
                      //.navigationBarHidden(true)
                    Spacer()
                }
            }
            Divider()
            NavigationLink(destination: AboutView()) {
                HStack {
                    Image(systemName: "info.circle")
                    Text("About")
                      //.navigationBarHidden(true)
                    Spacer()
                }
            }
            Divider()
            LogOutButton()
            Spacer()
        }
        //LogOutButton()
    }
}
