//
//  ActivitiesExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 27/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class ActivitiesExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(firstTimeClosure: () -> Void, SecondTimeClosure: () -> Void) {
        // Obtengo el acceso a UserDefault
        let defaults = UserDefaults.standard
        
        // Si soy capaz de obtener el valor del opcional
        if let _ = defaults.string(forKey: "activities") {
            // already saved
            SecondTimeClosure()
        } else { // first time
            firstTimeClosure()
        }
    }
    
}
