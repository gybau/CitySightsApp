//
//  MapView.swift
//  CitySightsApp
//
//  Created by Michał Ganiebny on 26/10/2022.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model:ContentModel
    
    var locations: [MKPointAnnotation] {
        
        // Create and empty array
        var annotations = [MKPointAnnotation]()
        
        // Create a set of annotations from out business model
        for business in model.restaurants + model.sights {
            
            // If the business has a latitude and longitude create a MPPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                // Create a new annotation
                let a = MKPointAnnotation()
                // Assign lat and long to the MKPointAnnotation
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                // Add the new annotation to the array of annotations
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
            
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO: Set the region
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the businesses
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // If the annotation is the user location don't assign it an AnnotationView
            if annotation is MKUserLocation {
                return nil
            }
            
            // Check if there's a reusable annotation before creating a new one
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            // If there isn't then create a new one
            if annotationView == nil {
                
                // Create annotation view for the annotation that was clicked by the user
                // Reuse identifier let's us reuse an already rendered, scrolled off screen AnnotationView
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            else {
                // We got reusable one
                annotationView!.annotation = annotation
            }
            
            // Return the annotationView
            return annotationView
        }
        
    }
    
}

