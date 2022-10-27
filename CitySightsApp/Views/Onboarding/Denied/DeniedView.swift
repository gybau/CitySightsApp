//
//  DeniedView.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 27/10/2022.
//

import SwiftUI

struct DeniedView: View {
    
    private let seaBlue = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 10) {
                Text("Whoops!")
                    .bold()
                    .font(.title)
                Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in the Settings.")
            }
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            Spacer()
            Button {
                // Go to settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text("Go to settings")
                        .bold()
                        .padding()
                }
            }
            .accentColor(seaBlue)
            Spacer()

        }
        .padding()
        .background(seaBlue)
    }
}

struct DeniedView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedView()
    }
}
