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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.shops!.count()
        if let shops = self.shops {
            return shops.count()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create Cells
        let cell: CollectionViewShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! CollectionViewShopCell
        
        let shop: Shop = (self.shops?.get(index: indexPath.row))!
        
        cell.refresh(shop: shop)
        
        return cell
        
    }
    
    
}
