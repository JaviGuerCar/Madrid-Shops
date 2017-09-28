//
//  SaveAllActivitiesInteractorImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 27/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import CoreData

class SaveAllActivitiesInteractorImpl: SaveAllActivitiesInteractor {
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        
        for i in 0..<activities.count() {
            let activity = activities.get(index: i)
            
            // Mapping Shop into ShopsCD with function mapShopIntoShopCD
            let _ = mapActivityIntoActivityCD(context: context, activity: activity)
            
        }
        do {
            try context.save()
            onSuccess(activities)
        } catch {
            //onError(nil)
        }
       
        
    }
    
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void) {
        execute(activities: activities, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    
}
