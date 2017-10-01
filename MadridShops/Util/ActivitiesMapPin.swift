//
//  ActivitiesMapPin.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 1/10/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class ActivitiesMapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var logo: String?
    var activityCD: ActivityCD
    
    init(coordinate: CLLocationCoordinate2D, activityCD: ActivityCD) {
        self.coordinate = coordinate
        self.title = activityCD.name
        self.subtitle = activityCD.address
        self.logo = activityCD.logo
        self.activityCD = activityCD
    }

    
}
