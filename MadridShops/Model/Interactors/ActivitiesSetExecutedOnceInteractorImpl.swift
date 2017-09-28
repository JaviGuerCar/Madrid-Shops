//
//  ActivitiesSetExecutedOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 27/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class ActivitiesSetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        
        // Grabo una key - value
        defaults.set("SAVED", forKey: "activities")
        
        // Esto te devuelve un Bool
        defaults.synchronize()
    }
}
