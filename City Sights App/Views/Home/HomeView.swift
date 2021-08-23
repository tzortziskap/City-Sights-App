//
//  HomeView.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 21/8/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            if !isMapShowing {
                VStack{
                    HStack{
                        Image(systemName: "location")
                        Text("San Fransisco")
                        Spacer()
                        Text("Switch to map view")
                    }
                    Divider()
                    BusinessList()
                    
                }
                .padding([.horizontal, .top])
            }else{
                
            }
            
        }else {
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
