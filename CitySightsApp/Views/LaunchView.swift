//
//  ContentView.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 23/10/2022.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        // Detect the authorization status of the user
        if model.authorizationState == .notDetermined {
            
            OnboardingView()
            
        }
        else if model.authorizationState == .authorizedWhenInUse ||
                    model.authorizationState == .authorizedAlways {
            
            // If authorized show home view
            HomeView()
            
        }
        else {
            
            DeniedView()
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
