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
    @State var selectedBusiness:Business?
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                if !isMapShowing {
                    VStack{
                        HStack{
                            Image(systemName: "location")
                            Text("San Fransisco")
                            Spacer()
                            Button("Switch to map view"){
                                self.isMapShowing = true
                            }
                        }
                        
                        Divider()
                        
                        BusinessList()
                        
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                }else{
                    ZStack (alignment: .top){
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                BusinessDetail(business: business)
                            }
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack{
                                Image(systemName: "location")
                                Text("San Fransisco")
                                Spacer()
                                Button("Switch to list view"){
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                    
                }
            }
        }else {
            ProgressView()
        }
    }
}

