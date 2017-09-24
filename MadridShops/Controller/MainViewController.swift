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
        
    }
    
    // El MainViewController mira el segue y en la función prepare
    // le pasamos el contexto al siguiente VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let vc = segue.destination as! ViewController
            vc.context = self.context
        }
    }


}
