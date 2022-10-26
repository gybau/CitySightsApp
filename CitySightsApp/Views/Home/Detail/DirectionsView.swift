//
//  DirectionsView.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 26/10/2022.
//

import SwiftUI

struct DirectionsView: View {
    
    var business:Business
    
    var body: some View {
        VStack {
            // Business Title
            HStack {
                BusinessTitle(business: business)
                Spacer()
                if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude, let name = business.name {
                    Link("Open in maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                }
            }
            .padding()
            DirectionsMap(business: business)
        }
    }
}


