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

class ActivitiesViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var context: NSManagedObjectContext!
    var locationList: [MapPin]?
    
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
        
        ActivitiesExecuteOnceInteractorImpl().execute(firstTimeClosure: {
            initializeData()
        }) {
            self.activitiesCollectionView.delegate = self
            self.activitiesCollectionView.dataSource = self
            self.annotationPins()
        }
    }
    
    func initializeData() {
        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
        
        //Download and Save
        downloadActivitiesInteractor.execute { (activities: Activities) in
            print("Acivity: " + activities.get(index: 0).name)
            
            // Save
            let cacheInteractor = SaveAllActivitiesInteractorImpl()
            cacheInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities: Activities) in
                
                ActivitiesSetExecutedOnceInteractorImpl().execute()
                self.activitiesCollectionView.delegate = self
                self.activitiesCollectionView.dataSource = self
                self.annotationPins()
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Compruebo si el ID del segue es el del Storyboard
        if segue.identifier == "ShowActivityDetailSegue" {
            // Establezco el VC de destino
            let vc = segue.destination as! ActivityDetailViewController
            let indexPath = self.activitiesCollectionView.indexPathsForSelectedItems![0]
            
            //let activity = self.activities?.get(index: indexPath.row)
            let activityCD: ActivityCD = fetchedResultsController.object(at: indexPath)
            vc.activity = mapActivityCDIntoActivity(activityCD: activityCD)
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
    
    // Función para pintar las anotations
    func annotationPins() {
        self.locationList = [MapPin]() // Creo un array de MapPin
        if let activitiesItems = fetchedResultsController.fetchedObjects {
            // Recorro los objetos de la consulta
            for item in activitiesItems {
                // Recupero las coordenadas de las shops
                if let longitude: CLLocationDegrees = Double(item.longitude),
                    let latitude: CLLocationDegrees = Double(item.latitude){
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let mapPin: MapPin = MapPin(coordinate: coordinate, title: item.name!, subtitle: item.address!)
                    self.locationList?.append(mapPin)
                    
                }
            }
        }
        
        self.mapView.addAnnotations(locationList!)
        
    }

}
