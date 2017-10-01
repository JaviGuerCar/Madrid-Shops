//
//  ViewController+Map.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 1/10/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import MapKit

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Delegate method
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        //print("Finish rendering")
        self.annotationPins()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKPointAnnotation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "ShopAnnotation"
        
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
            if let annotation = annotation as? ShopMapPin {
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
        if let annotation = view.annotation as? ShopMapPin {
            let shopCD = annotation.shopCD
            performSegue(withIdentifier: "ShowShopDetailSegue", sender: shopCD)
        }
    }
    
    
    // Función para pintar las anotations
    func annotationPins() {
        self.locationList = [ShopMapPin]() // Creo un array de ShopMapPin
        if let shopItems = fetchedResultsController.fetchedObjects {
            // Recorro los objetos de la consulta
            for item in shopItems {
                // Recupero las coordenadas de las shops
                if let longitude: CLLocationDegrees = Double(item.longitude),
                    let latitude: CLLocationDegrees = Double(item.latitude){
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let mapPin: ShopMapPin = ShopMapPin(coordinate: coordinate, shopCD: item)
                    self.locationList?.append(mapPin)
                    
                }
            }
        }
        
        self.map.addAnnotations(locationList!)
        
    }
}
