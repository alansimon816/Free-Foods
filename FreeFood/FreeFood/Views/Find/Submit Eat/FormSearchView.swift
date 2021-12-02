//
//  FormSearchView.swift
//  FreeFood
//
//  Created by user on 12/1/21.
//

import Foundation
import SwiftUI
import MapKit


struct FormSearchView: View {
    @ObservedObject var lm = LocationManager.shared
    @Binding var search: String
    @Binding var landmark: Landmark?
    @State private var landmarks = [Landmark]()
    @State private var listItemSelected = false
    
    var body: some View {
        HStack() {
            TextField("Search", text: $search, onEditingChanged: {_ in}) {
                self.getNearByLandmarks()
                listItemSelected = false
            }
        }
        FormSearchListView(landmarks: self.landmarks, landmark: self.$landmark, search: self.$search, listItemSelected: $listItemSelected).animation(.spring())
            
    }
    
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

struct FormSearchListView: View {
    let landmarks: [Landmark]
    @Binding var landmark: Landmark?
    @Binding var search: String
    @Binding var listItemSelected: Bool
        
    var body: some View {
        if !listItemSelected {
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    Button(action: {
                        search = landmark.title
                        self.landmark = landmark
                        listItemSelected.toggle()
                        print("\(landmark.name)")
                    }) {
                        VStack(alignment: .leading) {
                            Text(landmark.name)
                                .fontWeight(.bold)
                            Text(landmark.title)
                        }
                    }
                }
            }
        }
    }
}
