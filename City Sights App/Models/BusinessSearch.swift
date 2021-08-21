//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 21/8/21.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region:Decodable{
    var center = Coordinate()
}
