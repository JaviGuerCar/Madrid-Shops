//
//  CollectionViewShopCell.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 8/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewShopCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // necesito una shopCD
    var shopCD: ShopCD?
    
    func refresh(shopCD: ShopCD){
        self.shopCD = shopCD
        
        self.label.text = shopCD.name

        if let logoImage = shopCD.logoCache {
            self.imageView.image = UIImage(data: logoImage)
        }else{
            self.imageView.image = UIImage(named: "noImage.png")
        }
        
        imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
        
    }
}
