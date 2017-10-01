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

class ViewController: UIViewController {

    var context: NSManagedObjectContext!
    var locationList: [ShopMapPin]?
    var shopCD: ShopCD?
    var pin: ShopMapPin?

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
        
        // Centro el mapa
        let madridLocation = CLLocation(latitude: 40.41889, longitude: -3.69194)
        self.map.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        let reg = self.map.regionThatFits(region)
        self.map.setRegion(reg, animated: true)
        
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
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
            let vc = segue.destination as! ShopDetailViewController
            let shopCD: ShopCD = sender as! ShopCD
            vc.shopCD = shopCD
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

}

