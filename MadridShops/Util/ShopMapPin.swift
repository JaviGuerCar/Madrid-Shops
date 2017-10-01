//
//  ShopMapPin.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 21/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

import MapKit
import CoreLocation

class ShopMapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var logo: String?
    var shopCD: ShopCD
    
    init(coordinate: CLLocationCoordinate2D, shopCD: ShopCD) {
        self.coordinate = coordinate
        self.title = shopCD.name
        self.subtitle = shopCD.address
        self.logo = shopCD.logo
        self.shopCD = shopCD
    }
    
    
}


@available(iOS 11.0, *)
class ShopMapPinMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            
            guard let shopAnnotation = newValue as? ShopMapPin else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            
            let logoButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width:30, height: 30)))
            shopAnnotation.logo?.myLoad(completion: { (img: UIImage) in
                logoButton.setBackgroundImage(img, for: UIControlState())
            })
            rightCalloutAccessoryView = logoButton
            
            //glyphImage = shopAnnotation.logo?.getImage()
            
        }
    }
}

