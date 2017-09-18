//
//  String+Image.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 14/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

extension String {
    func loadImage(into imageView: UIImageView) {
        // lanzamos en 2º plano y despues volvemos al main
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: self),
                let data = NSData(contentsOf: url),
                let image = UIImage(data: data as Data){
                
            // Vuelvo al 1 plano para pintar la imagen
                OperationQueue.main.addOperation {
                    imageView.image = image
                }
            }
        }
    }
}
