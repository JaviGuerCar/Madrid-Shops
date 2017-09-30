//
//  ActivityDetailViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 25/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import SDWebImage

class ActivityDetailViewController: UIViewController {
    
    var activityCD: ActivityCD?
    
    @IBOutlet weak var activityDetailDescription: UITextView!
    @IBOutlet weak var mapImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.activityCD?.name
        self.activityDetailDescription.text = self.activityCD?.description_en

        if let staticMap = activityCD?.mapCache {
            self.mapImage.image = UIImage(data: staticMap)
        } else {
            self.mapImage.image = UIImage(named: "noImage.png")
        }
        
    }


}
