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
            
            // Mapping Shop into ShopsCD with function mapShopIntoShopCD
            let _ = mapShopIntoShopCD(context: context, shop: shop)
            
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
