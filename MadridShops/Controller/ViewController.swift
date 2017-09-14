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
        
        let downloadShopsInteractor: DownloadAllShopsinteractor = DownloadAllShopsinteractorNSURLSessionImpl()
        //let downloadShopsInteractor: DownloadAllShopsinteractor = DownloadAllShopInteractorNSOpImpl()

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // tengo que distinguir por donde he podido llegar al Segue
        // Para eso le pusimos el identificador en el StoryBoard
        if segue.identifier == "ShowShopDetailSegue" {
            // Tengo que indicarle el destino del segue
            // que no es más que el ViewController al que quiero llegar
            // en mi caso al ShopDetailViewController. Como segue.destination
            // me da un ViewController genérico, necesito convertirlo
            let vc = segue.destination as! ShopDetailViewController
            
            // necesito obtener el indexpath de la celda que se toca
            let indexPath = self.shopsCollectionView.indexPathsForSelectedItems![0]
            let selectedShop = self.shops?.get(index: indexPath.row)
            
            // Injecto la tienda (Inyeccion dependencias) a través de una propiedad
            // creada en el ShopDetailViewController, llamada "shop"
            vc.shop = selectedShop
        }
    }


}

