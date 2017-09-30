//
//  Shop.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

public class Shop {
    
    // Get Language
    var description: String {
        if Locale.current.regionCode! == "ES" {
            return self.description_es
        } else {
            return self.description_en
        }
    }
    
    // variables que necesito
    var name: String
    var description_es: String = ""
    var description_en: String = ""
    var latitude: Float? = nil
    var longitude: Float? = nil
    var image: String = ""
    var logo: String = ""
    var openingHours: String = ""
    var address: String = ""
 
    public init(name: String) {
        self.name = name
    }
}
