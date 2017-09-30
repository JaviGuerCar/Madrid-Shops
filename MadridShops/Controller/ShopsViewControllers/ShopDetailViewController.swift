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
    var shopCD: ShopCD?
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var shopOpeningHour: UILabel!
    @IBOutlet weak var shopAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shopCD?.name
        self.shopDetailDescription.text = self.shopCD?.description_en
        self.shopOpeningHour.text = self.shopCD?.openingHours
        self.shopAddress.text = self.shopCD?.address
        
        //self.shop?.image.loadImage(into: shopImage)
        //staticMapUrl.loadImage(into: shopImage)
        
        if let staticMap = shopCD?.mapCache {
            self.mapImage.image = UIImage(data: staticMap)
        } else {
            self.mapImage.image = UIImage(named: "noImage.png")
        }
        
        
    }

    
}
