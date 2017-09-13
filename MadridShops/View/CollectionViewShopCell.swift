//
//  CollectionViewShopCell.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 8/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class CollectionViewShopCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    // necesito una shop
    var shop: Shop?
    
    func refresh(shop: Shop){
        self.shop = shop
        
        self.label.text = shop.name
        // TODO: image view
        
        
    }
}
