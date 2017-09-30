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
    
    var activity: Activity?
    
    @IBOutlet weak var activityDetailDescription: UITextView!
    
    @IBOutlet weak var activityImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.activity?.name
        self.activityDetailDescription.text = self.activity?.description
        self.activity?.image.loadImage(into: activityImage)
        
        activityImage.sd_addActivityIndicator()
        activityImage.sd_setIndicatorStyle(.gray)

    }


}
