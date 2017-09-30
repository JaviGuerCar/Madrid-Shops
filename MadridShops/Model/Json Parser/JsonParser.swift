//
//  JsonParser.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 13/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

// Parse Shops
func parseShops(data: Data) -> Shops {
    let shops = Shops()
    
    do {
        // los datos los convertimos a objeto JSON con try catch
        // Y lo convierte en un diccionario con Claves, Valor
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        // Recorremos el array result recogido de Internet las tiendas
        for shopJson in result{
            let shop = Shop(name: shopJson["name"]! as! String)
            shop.address = shopJson["address"]! as! String
            shop.image        = shopJson["img"]              as! String
            shop.logo         = shopJson["logo_img"]         as! String
            shop.description_es  = shopJson["description_es"]   as! String
            shop.description_en  = shopJson["description_en"]   as! String
            shop.openingHours_es = shopJson["opening_hours_es"] as! String
            shop.openingHours_en = shopJson["opening_hours_en"] as! String
            shop.latitude     = (shopJson["gps_lat"]          as! String).floatValue
            shop.longitude    = (shopJson["gps_lon"]          as! String).floatValue
            
 
            
            shops.add(shop: shop)
        }
    } catch {
        print("Error parsing JSON")
    }
    
    return shops
}

// Parse Activities
func parseActivities(data: Data) -> Activities {
    
    let activities = Activities()
    
    do {
        // los datos los convertimos a objeto JSON con try catch
        // Y lo convierte en un diccionario con Claves, Valor
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for activityJson in result {
            let activity = Activity(name: activityJson["name"] as! String)
            activity.address = activityJson["address"] as! String
            activity.image        = activityJson["img"]              as! String
            activity.logo         = activityJson["logo_img"]         as! String
            activity.description_es  = activityJson["description_es"]   as! String
            activity.description_en  = activityJson["description_en"]   as! String
            activity.openingHours_es = activityJson["opening_hours_es"] as! String
            activity.openingHours_en = activityJson["opening_hours_en"] as! String
            activity.latitude     = (activityJson["gps_lat"]          as! String).floatValue
            activity.longitude    = (activityJson["gps_lon"]          as! String).floatValue
            
            activities.add(activity: activity)
        
        }
    } catch {
        print("Error parsing JSON")
    }
    
    return activities
}
