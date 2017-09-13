//
//  ShopsTests.swift
//  MadridShopsTests
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import XCTest
import MadridShops

class ShopsTests: XCTestCase {
    
    func testGivenEmptyShopsNumberShopsIsZero(){
        let mango = Shops()
        XCTAssertEqual(0, mango.count())
    }
    
    func testGivenShopsWithOneElementNumberShopsIsOne(){
        let mango = Shops()
        mango.add(shop: Shop(name: "Mango"))
        XCTAssertEqual(1, mango.count())
    }
    
}
