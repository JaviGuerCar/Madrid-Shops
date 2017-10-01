//
//  ActivitiesViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 24/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ActivitiesViewController: UIViewController  {

    var context: NSManagedObjectContext!
    var locationList: [ActivitiesMapPin]?
    var activityCD: ActivityCD?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        // Acceder a la localizacion
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Centro el mapa
        let madridLocation = CLLocation(latitude: 40.41889, longitude: -3.69194)
        self.mapView.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let reg = self.mapView.regionThatFits(region)
        self.mapView.setRegion(reg, animated: true)
        
        self.activitiesCollectionView.delegate = self
        self.activitiesCollectionView.dataSource = self
        //self.annotationPins()
        
    }
    
    // Segue a mano
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let shop = self.shops?.get(index: indexPath.row)
        let activityCD: ActivityCD = fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activityCD)
    }
    
    
    // Segue desde una celda
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Compruebo si el ID del segue es el del Storyboard
        if segue.identifier == "ShowActivityDetailSegue" {
            // Establezco el VC de destino
            let vc = segue.destination as! ActivityDetailViewController
            
            //let activity = self.activities?.get(index: indexPath.row)
            let activityCD: ActivityCD = sender as! ActivityCD
            vc.activityCD = activityCD
        }
    }
    
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
        
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ActivityCacheFile")
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
    
}
