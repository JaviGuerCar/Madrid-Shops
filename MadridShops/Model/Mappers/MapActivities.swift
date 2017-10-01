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
    activity.openingHours_en = activityCD.openingHours_en ?? ""
    activity.openingHours_es = activityCD.openingHours_es ?? ""
    activity.description_en = activityCD.description_en ?? ""
    activity.description_es = activityCD.description_es ?? ""
    
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
    activityCD.description_en = activity.description_en
    activityCD.description_es = activity.description_es
    activityCD.openingHours_en = activity.openingHours_en
    activityCD.openingHours_es = activity.openingHours_es
    activityCD.imageCache = LoadUrlImage(url: activity.image)
    activityCD.logoCache = LoadUrlImage(url: activity.logo)
    activityCD.mapCache = LoadUrlImage(url: "https://maps.googleapis.com/maps/api/staticmap?center=\(activity.latitude!),\(activity.longitude!)&zoom=17&size=320x220&markers=color:green%7C\(activity.latitude!),\(activity.longitude!)")

    return activityCD
}
