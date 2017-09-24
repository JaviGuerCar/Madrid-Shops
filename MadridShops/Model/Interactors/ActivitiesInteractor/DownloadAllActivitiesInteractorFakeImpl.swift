//
//  DownloadAllActivitiesInteractorFakeImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 24/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class DownloadAllActivitiesInteractorFakeImpl: DownloadAllActivitiesInteractor {
    
    // Implemento protocolos
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        
        let activities = Activities()
        
        for i in 0...10 {
            let activity = Activity(name: "Activity number \(i)")
            activity.address = "Adress \(1)"
            
            // Add activities
            activities.add(activity: activity)
        }
        
        // Main Thread
        OperationQueue.main.addOperation {
            onSuccess(activities)
        }
    }
    
    
}
