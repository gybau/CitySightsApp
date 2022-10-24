//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 24/10/2022.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            // If there is data, determine if we should show the map or the list
            if !isMapShowing {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "location")
                        Text("San Francisco")
                        Spacer()
                        Text("Show map View")
                    }
                    Divider()
                    BusinessList()
                    
                }
            }
            
        } else {
            // Show loading spinner if waiting for data fetch
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
