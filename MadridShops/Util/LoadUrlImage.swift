//
//  LoadUrlImage.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 30/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
func LoadUrlImage(url:String) -> Data? {

    if let myUrl = URL(string: url) {
        if let data = NSData(contentsOf: myUrl) {
            return data as Data
        } else {
            print("Data Error")
        }
    } else {
        print("Image Error")
    }
    return nil
}

