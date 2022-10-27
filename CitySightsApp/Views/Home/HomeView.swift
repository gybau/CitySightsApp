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
    @State var selectedBusiness:Business?
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                // If there is data, determine if we should show the map or the list
                if !isMapShowing {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "")
                            Spacer()
                            Button {
                                self.isMapShowing = true
                            } label: {
                                Text("Show map view")
                                    .foregroundColor(.blue)
                            }
                            
                            
                        }
                        Divider()
                        ZStack(alignment: .top) {
                            BusinessList()
                            HStack {
                                Spacer()
                                YelpAttribution(link: "https://yelp.com")
                            }
                            .padding(.trailing, -20)
                        }
                        
                    }
                    .padding([.horizontal, .top])
                    
                }
                else {
                    
                    ZStack(alignment: .top) {
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                // Create a business detail instance
                                // Pass in the selected business
                                BusinessDetail(business: business)
                            }
                        
                        ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .frame(height: 48)
                                HStack {
                                    Image(systemName: "location")
                                    Text(model.placemark?.locality ?? "")
                                    Spacer()
                                    Button {
                                        self.isMapShowing = false
                                    } label: {
                                        Text("Show list view")
                                            .foregroundColor(.blue)
                                    }
                                }.padding()
                            }
                            .padding()
                            
                        
                    }
                    
                }
            }.buttonStyle(.plain)
        }
        else {
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
