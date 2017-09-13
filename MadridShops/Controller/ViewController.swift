//
//  ViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shops: Shops?
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downloadShopsInteractor: DownloadAllShopsinteractor = DownloadAllShopInteractorNSOpImpl()

//        downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
//            // OK
//        }) { (error: Error) in
//            // Error
//        }
        
        downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
            // OK
            print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            // asigno delegado aqui que es donde recibo las tiendas
            // sino no mostraría nada porque no hay tiendas
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
        })
    }




}

