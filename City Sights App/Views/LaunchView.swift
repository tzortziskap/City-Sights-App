//
//  ContentView.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 20/8/21.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.authorizationState == .notDetermined {
            
        }
        else if model.authorizationState == CLAuthorizationStatus.authorizedAlways ||
                    model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse {
            HomeView()
        }
        else{
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ContentModel())
    }
}
