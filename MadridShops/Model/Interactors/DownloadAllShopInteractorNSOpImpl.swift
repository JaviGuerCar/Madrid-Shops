//
//  DownloadAllShopInteractorNSOpImpl.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 11/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

class DownloadAllShopInteractorNSOpImpl: DownloadAllShopsinteractor{
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    // Implements method
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        
        // Descargar los datos de Internet
        // Creamos la url
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        // Meterlo en una cola de Operacion
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: urlString), let data = NSData(contentsOf: url) as Data? {
                // los datos los convertimos a objeto JSON con try catch
                // Y lo convierte en un diccionario con Claves, Valor
                
                // Aqui le paso el parseo con la funcion creada en archivo aparte
                // Así todo queda más limpio
                let shops = parseShops(data: data)
                
                // Volver al hilo principal
                OperationQueue.main.addOperation {
                    // LLamo a la clasura
                    onSuccess(shops)
                }
                    
                
            }
        
        }
        
        
    }
    
    
}
