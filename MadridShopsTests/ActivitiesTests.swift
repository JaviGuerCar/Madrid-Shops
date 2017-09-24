//
//  ActivitiesTests.swift
//  MadridShopsTests
//
//  Created by Fco. Javier Guerrero Carmona on 23/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import XCTest
import MadridShops

class ActivitiesTests: XCTestCase {
    
    func testGivenEmptyActivitiesNumberActivitiesIsZero(){
        let tourMadrid = Activities()
        XCTAssertEqual(0, tourMadrid.count())
    }
    
    func testGivenActivitiesWithOneElementNumberActivitiesIsOne(){
        let tourMadrid = Activities()
        tourMadrid.add(activity: Activity(name: "Tour Madrid"))
        XCTAssertEqual(1, tourMadrid.count())
    }
    
}
