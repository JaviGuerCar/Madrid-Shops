//
//  SaveAllActivitiesInteractor.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 27/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import CoreData

protocol SaveAllActivitiesInteractor {
    // execute: save all activities. Return on the main thread
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void)
}
