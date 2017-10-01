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
    var shopCD: ShopCD?
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopOpeningHour: UILabel!
    @IBOutlet weak var shopAddress: UILabel!
    @IBOutlet weak var shopTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shopCD?.name
        
        // Get Language
        if Locale.current.regionCode! == "ES" {
            self.shopDetailDescription.text = self.shopCD?.description_es
            self.shopOpeningHour.text = self.shopCD?.openingHours_es
        } else {
            self.shopDetailDescription.text = self.shopCD?.description_en
            self.shopOpeningHour.text = self.shopCD?.openingHours_en
        }
        
        self.shopAddress.text = self.shopCD?.address
        self.shopTitle.text = self.shopCD?.name
        
        // Cached images
        if let staticMap = shopCD?.mapCache {
            self.mapImage.image = UIImage(data: staticMap)
        } else {
            self.mapImage.image = UIImage(named: "noImage.png")
        }
        
        if let imageShop = shopCD?.imageCache {
            self.shopImage.image = UIImage(data: imageShop)
        } else {
            self.shopImage.image = UIImage(named: "noImage.png")
        }
        
        
    }

    
}
