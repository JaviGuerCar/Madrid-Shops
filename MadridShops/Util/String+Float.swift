//
//  String+Float.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 23/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
