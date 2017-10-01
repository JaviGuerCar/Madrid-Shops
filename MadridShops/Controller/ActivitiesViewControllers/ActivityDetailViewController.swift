//
//  ActivityDetailViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 25/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    var activityCD: ActivityCD?
    
    @IBOutlet weak var activityDetailDescription: UITextView!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var activityAddress: UILabel!
    @IBOutlet weak var activityOpeningHour: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Language
        if Locale.current.regionCode! == "ES" {
            self.activityDetailDescription.text = self.activityCD?.description_es
            self.activityOpeningHour.text = self.activityCD?.openingHours_es
        } else {
            self.activityDetailDescription.text = self.activityCD?.description_en
            self.activityOpeningHour.text = self.activityCD?.openingHours_en
        }
        
        self.title = self.activityCD?.name
        self.activityAddress.text = self.activityCD?.address
        self.activityTitle.text = self.activityCD?.name

        if let staticMap = activityCD?.mapCache {
            self.mapImage.image = UIImage(data: staticMap)
        } else {
            self.mapImage.image = UIImage(named: "noImage.png")
        }
        
        if let imageActivity = activityCD?.imageCache {
            self.activityImage.image = UIImage(data: imageActivity)
        } else {
            self.activityImage.image = UIImage(named: "noImage.png")
        }
        
    }


}
