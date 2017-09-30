//
//  MapShops.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 18/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import CoreData

func mapShopCDIntoShop(shopCD: ShopCD) -> Shop {
    // Mapping Shop into ShopsCD
    let shop = Shop(name: shopCD.name ?? "")
    shop.address = shopCD.address ?? ""
    shop.image = shopCD.image ?? ""
    shop.logo = shopCD.logo ?? ""
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    shop.description_es = shopCD.description_es ?? ""
    shop.description_en = shopCD.description_en ?? ""
    shop.openingHours = shopCD.openingHours ?? ""
    
    return shop
}

// Necesito inyecarle un contexto como parámetro
func mapShopIntoShopCD(context: NSManagedObjectContext, shop: Shop) -> ShopCD {
    // Mapping Shop into ShopsCD
    let shopCD = ShopCD(context: context)
    shopCD.name = shop.name
    shopCD.address = shop.address
    shopCD.image = shop.image
    shopCD.logo = shop.logo
    shopCD.latitude = shop.latitude ?? 0.0
    shopCD.longitude = shop.longitude ?? 0.0
    shopCD.description_es = shop.description_es
    shopCD.description_en = shop.description_en
    shopCD.openingHours = shop.openingHours
    
    return shopCD
}
