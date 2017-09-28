//
//  MainViewController.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 11/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import CoreData
// Importamos la librería DotsLoading
import FillableLoaders

class MainViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAppData()
    }
    
    func loadAppData() {
        ExecuteOnceInteractorImpl().execute(firstTimeClosure: {
            initializeShopsData()
        }) {
            // SecondTimeCLosure
        }
    }
    
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
    
    func initializeActivitiesData() {
        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
        
        //Download and Save
        downloadActivitiesInteractor.execute { (activities: Activities) in
            print("Acivity: " + activities.get(index: 0).name)
            
            // Save
            let cacheInteractor = SaveAllActivitiesInteractorImpl()
            cacheInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities: Activities) in
                SetExecutedOnceInteractorImpl().execute()
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


}
