//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 14/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import SDWebImage

class ShopDetailViewController: UIViewController {

    // Me creo una propiedad para injectar dependencias en el ShopDetailVC
    var shop: Shop?
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopOpeningHour: UILabel!
    @IBOutlet weak var shopAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longitude = (shop?.longitude)!
        let latitude = (shop?.latitude)!
        
        // URL Static Map
         var staticMapUrl = "https://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&zoom=17&size=320x220&markers=color:green%7C\(latitude),\(longitude)"
        
        self.title = self.shop?.name
        self.shopDetailDescription.text = self.shop?.description
        //self.shop?.image.loadImage(into: shopImage)
        staticMapUrl.loadImage(into: shopImage)
        
        shopImage.sd_addActivityIndicator()
        shopImage.sd_setIndicatorStyle(.gray)
        
        self.shopOpeningHour.text = self.shop?.openingHours
        self.shopAddress.text = self.shop?.address
        
        
    }

    
    
}
