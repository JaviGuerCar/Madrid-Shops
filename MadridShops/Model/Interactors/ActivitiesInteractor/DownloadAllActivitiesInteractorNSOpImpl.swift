//
//  DownloadAllActivitiesInteractorNSOpImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 25/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class DownloadAllActivitiesInteractorNSOpImpl: DownloadAllActivitiesInteractor {
    
    // Implemento protocolos
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        // URL
        let urlString = "https://madrid-shops.com/json_new/getActivities.php"
        
        // Download in Background
        let queue = OperationQueue()
        queue.addOperation{
            if let url = URL(string: urlString),
                let data = NSData(contentsOf: url) as Data? {
                
                let activities = parseActivities(data: data)
                    
                // Main Thread
                OperationQueue.main.addOperation {
                    onSuccess(activities)
                }
                
            }
        
        }
        
    }
    
}
