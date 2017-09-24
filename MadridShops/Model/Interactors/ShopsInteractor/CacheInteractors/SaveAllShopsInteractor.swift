//
//  SaveAllShopsInteractor.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 16/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import CoreData

protocol SaveAllShopsInteractor{
    // execute: save all shops. Return on the main thread
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void)
}
