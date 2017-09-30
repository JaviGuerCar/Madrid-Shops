//
//  ExecuteOnceInteractor.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 18/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

// este protocolo lo hacemos para que sólo se descargue una vez los datos
protocol ExecuteOnceInteractor {
    func execute(firstTimeClosure: () -> Void)
}
