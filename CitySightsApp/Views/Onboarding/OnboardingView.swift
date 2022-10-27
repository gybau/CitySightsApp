//
//  OnboardingView.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 27/10/2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model:ContentModel
    @State private var selectedTab = 0
    
    private let blue = Color(red: 0/255, green: 133/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
        VStack {
            
            TabView(selection: $selectedTab) {
                
                VStack (spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City Sights let's you find the best of the city!")
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .tag(0)
                
                VStack (spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City Sights let's you find the best of the city!")
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            Button {
                if selectedTab == 0 {
                    selectedTab = 1
                }
                else if selectedTab == 1 {
                    model.requestUserLocationAuthorization()
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text(selectedTab == 0 ? "Next" : "Get my location")
                        .bold()
                        .padding()
                }
            }
            .accentColor(selectedTab == 0 ? blue : turquoise)
        }
        .padding()
        .background(selectedTab == 0 ? blue : turquoise)

    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
