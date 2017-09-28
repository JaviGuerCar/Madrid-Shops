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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var context: NSManagedObjectContext!
    var locationList: [MapPin]?

    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        
        // Acceder a la localizacion
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Ejecuto el Interactor y la primera o segunda clausura según corresponda
        ExecuteOnceInteractorImpl().execute(firstTimeClosure: {
            initializeData()
        }) {
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
            self.annotationPins()
        }
        
        // Centro el mapa
        let madridLocation = CLLocation(latitude: 40.41889, longitude: -3.69194)
        self.map.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let reg = self.map.regionThatFits(region)
        self.map.setRegion(reg, animated: true)
        
        
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
                    // Cargamos los mapas
                    self.annotationPins()
            })
        }
    }

    // Segue a mano
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
            
            // Injecto la tienda (Inyeccion dependencias) a través de una propiedad creada en el ShopDetailViewController, llamada "shop"
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
    
    // Función para pintar las anotations
    func annotationPins() {
        self.locationList = [MapPin]() // Creo un array de MapPin
        if let shopItems = fetchedResultsController.fetchedObjects {
            // Recorro los objetos de la consulta
            for item in shopItems {
                // Recupero las coordenadas de las shops
                if let longitude: CLLocationDegrees = Double(item.longitude),
                    let latitude: CLLocationDegrees = Double(item.latitude){
                        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let mapPin: MapPin = MapPin(coordinate: coordinate, title: item.name!, subtitle: item.address!)
                        self.locationList?.append(mapPin)

                }
            }
        }

        self.map.addAnnotations(locationList!)

    }

}

