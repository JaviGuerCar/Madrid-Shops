//
//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 18/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(firstTimeClosure: () -> Void) {
        // Obtengo el acceso a UserDefault
        let defaults = UserDefaults.standard
        
        // Si soy capaz de obtener el valor del opcional
        if let _ = defaults.string(forKey: "once") {
            // already saved
        } else { // first time
            firstTimeClosure()
        }
    }

}

