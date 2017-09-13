//
//  Shops.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

public protocol ShopsProtocol {
    func count() -> Int
    func add(shop: Shop)
    func get(index: Int) -> Shop
}

// Un agregado
public class Shops: ShopsProtocol {
    //
    private var shopsList: [Shop]?
    
    // Nos creamos un init para que lo vea desde los Test
    public init(){
        self.shopsList = []
    }
    
    // Implemento los protocolos
    public func count() -> Int {
        return (shopsList?.count)!
    }
    
    public func add(shop: Shop) {
        shopsList?.append(shop)
    }
    
    public func get(index: Int) -> Shop {
        return (shopsList?[index])!
    }
    
    
    
    
    
}
