//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 27/8/21.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var location:[MKAnnotation] {
        var annotations = [MKAnnotation]()
        
        for business in model.restaurants + model.sights {
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude{
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        
//        uiView.addAnnotations(self.location)
        uiView.showAnnotations(self.location, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
