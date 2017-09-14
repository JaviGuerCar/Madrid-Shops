//
//  JsonParser.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 13/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

func parseShops(data: Data) -> Shops {
    let shops = Shops()
    
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        // Recorremos el array result recogido de Internet las tiendas
        for shopJson in result{
            let shop = Shop(name: shopJson["name"]! as! String)
            shop.address = shopJson["address"]! as! String
            shop.description  = shopJson["description_es"]   as! String
            shop.latitude     = shopJson["gps_lat"]          as? Float
            shop.longitude    = shopJson["gps_lon"]          as? Float
            shop.image        = shopJson["img"]              as! String
            shop.logo         = shopJson["logo_img"]         as! String
            shop.openingHours = shopJson["opening_hours_es"] as! String
            
            shops.add(shop: shop)
        }
    } catch {
        
    }
    
    return shops
}
