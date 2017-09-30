//
//  ViewController+CollectionViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.shops!.count()
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create Cells
        let cell: CollectionViewShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! CollectionViewShopCell
        
        //let shop: Shop = (self.shops?.get(index: indexPath.row))!
        let shopCD: ShopCD = fetchedResultsController.object(at: indexPath)
        
        // Para convertirlo a objeto CD, pues le paso la función para Mapear
        cell.refresh(shopCD: shopCD)
        
        return cell
        
    }
    
    
}
