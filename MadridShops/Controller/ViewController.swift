//
//  ViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context: NSManagedObjectContext!
    var shops: Shops?
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsinteractorNSURLSessionImpl()
        
        downloadShopsInteractor.execute{ (shops: Shops) in
            // OK
            print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            // asigno delegado aqui que es donde recibo las tiendas
            // sino no mostraría nada porque no hay tiendas
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
            
            // Despues de descargarlo lo salvo en BD con CoreData
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context
                , onSuccess: { (shops: Shops) in
                    
            })
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop = self.shops?.get(index: indexPath.row)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
    // Segue desde una celda
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
            //let indexPath = self.shopsCollectionView.indexPathsForSelectedItems![0]
            //let selectedShop = self.shops?.get(index: indexPath.row)
            
            // Injecto la tienda (Inyeccion dependencias) a través de una propiedad
            // creada en el ShopDetailViewController, llamada "shop"
            // vc.shop = selectedShop
            vc.shop = sender as? Shop
        }
    }


}

