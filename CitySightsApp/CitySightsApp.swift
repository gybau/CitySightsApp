//
//  CitySightsAppApp.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 23/10/2022.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(ContentModel())
        }
    }
}
