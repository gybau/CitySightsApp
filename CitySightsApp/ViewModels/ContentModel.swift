//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 23/10/2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Assign ContentModel as the location manager delegate
        locationManager.delegate = self
        
        // Request when in use authorization
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user after receiving the authorization
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // Once we have the location, pass it into the YELP api
            getBussinesses(category: Constants.restaurantsKey, location: userLocation!)
            getBussinesses(category: Constants.sightsKey, location: userLocation!)
        }
        
        
        
        
        
    }
    
    // MARK: Yelp API methods
    func getBussinesses(category: String, location:CLLocation) {
        
        // Create URL
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URL Session
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    do {
                        // Parse JSON
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Sort businesses by distance from user
                        var businesses = result.businesses
                        businesses.sort { b1, b2 in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Get image data for each business
                        for b in result.businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.restaurantsKey:
                                self.restaurants = businesses
                            case Constants.sightsKey:
                                self.sights = businesses
                            default:
                                break
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
                
            }
            // Start the data task
            dataTask.resume()
        }
    }
}
