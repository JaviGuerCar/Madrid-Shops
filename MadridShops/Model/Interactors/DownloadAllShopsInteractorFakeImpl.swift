//
//  DownloadAllShopsInteractorFakeImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorFakeImpl: DownloadAllShopsinteractor{
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    // Implements method
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        // Fake shops
        let shops = Shops()
        
        for i in 0...10 {
            let shop = Shop(name: "Shop number \(i)")
            shop.address = "Address \(i)"
            
            shops.add(shop: shop)
        }
        
        // Volver al hilo principal
        OperationQueue.main.addOperation {
            // LLamo a la clasura
            onSuccess(shops)
        }
        
    }
    
    
}
