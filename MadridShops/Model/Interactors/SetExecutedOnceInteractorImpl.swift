//
//  SetExecutedOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 18/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        
        // Grabo una key - value
        defaults.set("SAVED", forKey: "once")
        
        // Esto te devuelve un Bool
        defaults.synchronize()
    }
}
