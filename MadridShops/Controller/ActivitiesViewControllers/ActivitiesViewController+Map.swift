//
//  ActivitiesViewController+Map.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 1/10/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import MapKit

extension ActivitiesViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Delegate method
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        //print("Finish rendering")
        self.annotationPins()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "ActivityAnnotation"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "mapicon")
            
            let logoButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            if let annotation = annotation as? ActivitiesMapPin {
                annotation.logo?.myLoad(completion: { (img: UIImage) in
                    logoButton.setBackgroundImage(img, for: UIControlState())
                })
            }
            
            annotationView.rightCalloutAccessoryView = logoButton
            
        }
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Touch calloutAccessory")
        if let annotation = view.annotation as? ActivitiesMapPin {
            let activityCD = annotation.activityCD
            performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activityCD)
        }
    }
    
    
    // Función para pintar las anotations
    func annotationPins() {
        self.locationList = [ActivitiesMapPin]() // Creo un array de ShopMapPin
        if let activityItems = fetchedResultsController.fetchedObjects {
            // Recorro los objetos de la consulta
            for item in activityItems {
                // Recupero las coordenadas de las shops
                if let longitude: CLLocationDegrees = Double(item.longitude),
                    let latitude: CLLocationDegrees = Double(item.latitude){
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let mapPin: ActivitiesMapPin = ActivitiesMapPin(coordinate: coordinate, activityCD: item)
                    self.locationList?.append(mapPin)
                    
                }
            }
        }
        
        self.mapView.addAnnotations(locationList!)
        
    }
    
}
