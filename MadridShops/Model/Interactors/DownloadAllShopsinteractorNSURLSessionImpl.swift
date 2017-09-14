//
//  DownloadAllShopsinteractorNSURLSessionImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 13/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class DownloadAllShopsinteractorNSURLSessionImpl: DownloadAllShopsinteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        // URL
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        // Me creo una sesion
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    // Si ha habido error
                    if error == nil {
                        // OK
                        let shops = parseShops(data: data!)
                        onSuccess(shops)
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
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    
}
