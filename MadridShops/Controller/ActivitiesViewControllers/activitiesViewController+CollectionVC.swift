//
//  activitiesViewController+CollectionVC.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 24/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import Foundation
import UIKit

extension ActivitiesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionViewActivityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCell", for: indexPath) as! CollectionViewActivityCell
        
        //let activity: Activity = (self.activities?.get(index: indexPath.row))!
        let activityCD: ActivityCD = fetchedResultsController.object(at: indexPath)
        
        cell.refresh(activity: mapActivityCDIntoActivity(activityCD: activityCD))
        
        return cell
        
    }
    
    
}
