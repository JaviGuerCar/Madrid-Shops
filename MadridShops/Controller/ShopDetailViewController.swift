//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 14/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {

    // Me creo una propiedad para injectar dependencias en el ShopDetailVC
    var shop: Shop?
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopOpeningHour: UILabel!
    @IBOutlet weak var shopAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shop?.name
        self.shopDetailDescription.text = self.shop?.description
        self.shop?.image.loadImage(into: shopImage)
        self.shopOpeningHour.text = self.shop?.openingHours
        self.shopAddress.text = self.shop?.address
        
    }

    
    
}
