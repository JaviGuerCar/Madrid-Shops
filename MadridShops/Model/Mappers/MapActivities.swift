//
//  MapActivities.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 27/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import CoreData

func mapActivityCDIntoActivity(activityCD: ActivityCD) -> Activity {
    // Mapping Activities into ActivitiesCD
    let activity = Activity(name: activityCD.name ?? "")
    activity.address = activityCD.address ?? ""
    activity.image = activityCD.image ?? ""
    activity.logo = activityCD.logo ?? ""
    activity.latitude = activityCD.latitude
    activity.longitude = activityCD.longitude
    activity.openingHours = activityCD.openingHours ?? ""
    activity.description = activityCD.description_es ?? ""
    
    return activity
}

// Necesito inyecarle un contexto como parámetro
func mapActivityIntoActivityCD(context: NSManagedObjectContext, activity: Activity) -> ActivityCD {
    // Mapping Shop into ShopsCD
    let activityCD = ActivityCD(context: context)
    activityCD.name = activity.name
    activityCD.address = activity.address
    activityCD.image = activity.image
    activityCD.logo = activity.logo
    activityCD.latitude = activity.latitude ?? 0.0
    activityCD.longitude = activity.longitude ?? 0.0
    activityCD.description_es = activity.description
    activityCD.openingHours = activity.openingHours
    
    return activityCD
}
