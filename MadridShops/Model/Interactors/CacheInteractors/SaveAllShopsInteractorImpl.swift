//
//  SaveAllShopsInteractorImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 16/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import CoreData

class SaveAllShopsInteractorImpl: SaveAllShopsInteractor {
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        // Recorro todas las tiendas
        // Creo en el contexto objetos de tipo Core Data
        // Grabo el contexto
        for i in 0 ..< shops.count() {
            let shop = shops.get(index: i)
            
            // Mapping Shop into ShopsCD
            let shopCD = ShopCD(context: context)
            shopCD.name = shop.name
            shopCD.address = shop.address
            shopCD.image = shop.image
            shopCD.logo = shop.logo
//            shopCD.latitude = shop.latitude!
//            shopCD.longitude = shop.longitude!
//            shopCD.description_es = shop.description
//            shopCD.openingHours = shop.openingHours
        }
        
        do {
            try context.save()
            onSuccess(shops)
        }catch{
            //onError(nil)
        }
        
    }
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    
}
