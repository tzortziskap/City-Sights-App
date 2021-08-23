//
//  ContentModel.swift
//  City Sights App
//
//  Created by Tzortzis Kapellas on 20/8/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Set content model as delegate of the location manager
        locationManager.delegate = self
        
        // Request Permission
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    // MARK = Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse{
            
            //We have permission
            // TODO: Start geolocating the user
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == .denied {
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            getBusinesses(category: Constants.RESTAURANTS, location: userLocation!)
            getBusinesses(category: Constants.ARTS, location: userLocation!)
        }
        
        // TODO: If we have the coordinates of the user, send into Yelp API
        
    }
    
    // MARK: -Yelp API methods
    
    func getBusinesses(category:String, location:CLLocation){
        
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude\(location.coordinate.longitude)&categories=\(category)&limit=6"
//        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: Constants.YELPAPIURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: Constants.LATITUDE, value: String(location.coordinate.latitude)),
            URLQueryItem(name: Constants.LONGITUDE, value: String(location.coordinate.longitude)),
            URLQueryItem(name: Constants.CATEGORIES, value: category),
            URLQueryItem(name: Constants.LIMIT, value: Constants.LIMITVALUE)
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = Constants.GETTYPEREQUEST
            request.addValue("\(Constants.BEARER) \(Constants.APIKEY)", forHTTPHeaderField: Constants.AUTHORIZATION)
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) {(data, response, error) in
                if error == nil {
                    do {
                        
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        var businesses = result.businesses
                        businesses.sort { (b1,b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            if category == Constants.ARTS {
                                self.sights = businesses
                            }else if category == Constants.RESTAURANTS {
                                self.restaurants = businesses
                            }
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            }
            
            dataTask.resume()
            
        }
    }
}
