//
//  DownloadAllActivitiesInteractorNSURLSessionImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 25/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class DownloadAllActivitiesInteractorNSURLSessionImpl: DownloadAllActivitiesInteractor {
    
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        
        let urlString = "https://madrid-shops.com/json_new/getActivities.php"
        
        let session = URLSession.shared
        if let url = URL(string: urlString){
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    // Si ha habido error
                    if error == nil {
                        // OK
                        let activities = parseActivities(data: data!)
                        onSuccess(activities)
                    } else {
                        // Error
                        if let myError = onError {
                            myError(error!)
                        }
                    }
                }
            }
            
         task.resume()
            
        }

        
    }
    

    
    
    
}
