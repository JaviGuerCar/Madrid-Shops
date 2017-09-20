//
//  ViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var context: NSManagedObjectContext!
    //var shops: Shops?
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Acceder a la localizacion
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        ExecuteOnceInteractorImpl().execute {
            initializeData()
        }
        
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        // Centro el mapa
        let antequeraLocation = CLLocation(latitude: 40.41889, longitude: -3.69194)
        self.map.setCenter(antequeraLocation.coordinate, animated: true)
        
    }
    
    // Función de descarga de los datos
    func initializeData() {
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsinteractorNSURLSessionImpl()
        
        downloadShopsInteractor.execute{ (shops: Shops) in
            // OK
            print("Name: " + shops.get(index: 0).name)
            //self.shops = shops
            
            
            // Despues de descargarlo lo salvo en BD con CoreData
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context
                , onSuccess: { (shops: Shops) in
                    
                    // Marco si se que ya se ha descargado una vez
                    SetExecutedOnceInteractorImpl().execute()
                    
                    // asigno delegado aqui que es donde guardo las tiendas
                    // sino no mostraría nada porque no hay tiendas
                    self._fetchedResultsController = nil
                    self.shopsCollectionView.delegate = self
                    self.shopsCollectionView.dataSource = self
                    // Recargamos los datos
                    self.shopsCollectionView.reloadData()
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let shop = self.shops?.get(index: indexPath.row)
        let shopCD: ShopCD = fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shopCD)
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
            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
        }
    }
    
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopCacheFile")
        // Hacerse delegado
        //aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    // Implemento el método de Delegado de Core Location Manger Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Obtengo la primera localizacion
        let location = locations[0]
        self.map.setCenter(location.coordinate, animated: true)
    }   

}

