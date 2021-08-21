//
//  City_Sights_AppApp.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 20/8/21.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
