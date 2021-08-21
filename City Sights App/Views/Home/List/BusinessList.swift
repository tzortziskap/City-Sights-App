//
//  BusinessList.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 21/8/21.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.restaurants) { business in
                    Text(business.name ?? "")
                    Divider()
                }
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
