//
//  ListPlacesView.swift
//  FreeFood
//
//  Created by user on 11/30/21.
//

import SwiftUI
import MapKit

struct ListPlacesView: View {
    let landmarks: [Landmark]
    @Binding var showResults: Bool
    var onTap: () -> ()
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if showResults {
                    Text("Hide results")
                } else {
                    Text("Show results")
                }
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
                .gesture(TapGesture().onEnded(self.onTap))
            
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .fontWeight(.bold)
                        Text(landmark.title)
                    }
                }
            }
        }.cornerRadius(10)
    }
}
