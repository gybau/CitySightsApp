//
//  YelpAttribution.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 27/10/2022.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link:String
    
    var body: some View {
        if let url = URL(string: link) {
            Link(destination: url) {
                Image("yelp")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
            }
        }
    }
}


