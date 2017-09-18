//
//  AppDelegate.swift
//  MadridShops
//
//  Created by Fco. Javier Guerrero Carmona on 7/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cds = CoreDataStack()
    var context: NSManagedObjectContext?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.context = cds.createContainer(dbName: "MadridShops").viewContext
        
        // Como el rootViewController es un NavigationController le hago un cast
        let navVC = self.window?.rootViewController as! UINavigationController
        // Ahora accedo al top del navVC, que es el MainViewController en mi Storyboard
        let mainVC = navVC.topViewController as! MainViewController
        // y le tengo que pasar el contexto para guardar la BD
        mainVC.context = self.context
        
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else { return }
        self.cds.saveContext(context: context)
    }


}

