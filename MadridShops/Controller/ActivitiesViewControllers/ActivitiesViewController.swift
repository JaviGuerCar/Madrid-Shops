//
//  ActivitiesViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 24/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {

    var activities: Activities?
    
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorFakeImpl()
        
        downloadActivitiesInteractor.execute { (activities: Activities) in
            print("Acivity: " + activities.get(index: 0).name)
            // Guardo las activities pasadas en esta función en la variable creada para usarla cuando la necesite
            self.activities = activities
            
            self.activitiesCollectionView.delegate = self
            self.activitiesCollectionView.dataSource = self
        }

    }

}
