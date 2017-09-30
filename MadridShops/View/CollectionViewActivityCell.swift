//
//  CollectionViewActivityCell.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 24/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class CollectionViewActivityCell: UICollectionViewCell {
    
    var activity: Activity?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(activity: Activity){
        self.activity = activity
        
        // Paint cell
        self.label.text = activity.name
        self.activity?.logo.loadImage(into: imageView)
        
        imageView.sd_addActivityIndicator()
        imageView.sd_setIndicatorStyle(.gray)
        
        imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
        
    }
    
}
