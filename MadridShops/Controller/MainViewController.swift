//
//  MainViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 11/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration

class MainViewController: UIViewController {
    
    var context: NSManagedObjectContext!

    @IBOutlet weak var OverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.OverView.isHidden = true
        self.loadingLabel.isHidden = true
        self.loadAppData()
        
    }

    
    // Load Data
    func loadAppData() {
        ExecuteOnceInteractorImpl().execute(firstTimeClosure:{
            if CheckConnection.isInternetAvailable() {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.OverView.isHidden = false
                self.loadingLabel.isHidden = false
                self.initializeShopsData()
            } else {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.OverView.isHidden = true
                self.loadingLabel.isHidden = true
                self.showAlert()
            }
        })
    }
    
    // Initialize Shops Data
    func initializeShopsData() {
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsinteractorNSURLSessionImpl()
        
        //Download and Save
        downloadShopsInteractor.execute { (shops: Shops) in
            print("Name: " + shops.get(index: 0).name)
            
            // Save
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                
                self.initializeActivitiesData()
            })
        }
    }
    
    // Initialize Activities Data
    func initializeActivitiesData() {
        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
        
        //Download and Save
        downloadActivitiesInteractor.execute { (activities: Activities) in
            print("Acivity: " + activities.get(index: 0).name)
            
            // Save
            let cacheInteractor = SaveAllActivitiesInteractorImpl()
            cacheInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities: Activities) in
                SetExecutedOnceInteractorImpl().execute()
                self.activityIndicator.stopAnimating()
                self.OverView.isHidden = true
                self.loadingLabel.isHidden = true
            })
        }
    }

    
    // El MainViewController mira el segue y en la función prepare
    // le pasamos el contexto al siguiente VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let vc = segue.destination as! ViewController
            vc.context = self.context
        } else{
            let vc = segue.destination as! ActivitiesViewController
            vc.context = self.context
        }
    }
    
    
    
    // Alert if no connection
    func showAlert() {
        let alert = UIAlertController(title: "No hay conexión de red", message: "No se puede establecer conexión con la red. Verifica la conexión y vuelve a intentarlo", preferredStyle: UIAlertControllerStyle.alert)
        //alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
        
        let retry = UIAlertAction(title: "Retry", style: .default) { (alertAction) in
            self.loadAppData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (cancelAction) in }
        
        alert.addAction(retry)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }


}
