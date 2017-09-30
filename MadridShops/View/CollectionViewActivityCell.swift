//
//  CollectionViewActivityCell.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 24/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class CollectionViewActivityCell: UICollectionViewCell {
    
    var activityCD: ActivityCD?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(activityCD: ActivityCD){
        self.activityCD = activityCD
        
        // Paint cell
        self.label.text = activityCD.name
        
        if let logoImage = activityCD.logoCache {
            self.imageView.image = UIImage(data: logoImage)
        }else{
            self.imageView.image = UIImage(named: "noImage.png")
        }
        
    }
    
}
