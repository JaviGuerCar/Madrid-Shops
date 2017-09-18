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
    @IBOutlet weak var redRectangle: UIView!
    var myLoader: WavesLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 180, y: 25))
        starPath.addLine(to: CGPoint(x: 195.16, y: 43.53))
        starPath.addLine(to: CGPoint(x: 220.9, y: 49.88))
        starPath.addLine(to: CGPoint(x: 204.54, y: 67.67))
        starPath.addLine(to: CGPoint(x: 205.27, y: 90.12))
        starPath.addLine(to: CGPoint(x: 180, y: 82.6))
        starPath.addLine(to: CGPoint(x: 154.73, y: 90.12))
        starPath.addLine(to: CGPoint(x: 155.46, y: 67.67))
        starPath.addLine(to: CGPoint(x: 139.1, y: 49.88))
        starPath.addLine(to: CGPoint(x: 164.84, y: 43.53))
        starPath.close()
        starPath.fill()
        
        let myPath = starPath.cgPath
        self.myLoader = WavesLoader.showLoader(with: myPath)
        self.view.addSubview(self.myLoader!)
        
        let rect = CGRect(x: 10, y: 100, width: 200, height: 200)
        let vista = UIView(frame: rect)
        vista.backgroundColor = UIColor.blue
        self.view.addSubview(vista)
        
        // gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateView))
        tapGesture.numberOfTouchesRequired = 1 // num dedos
        tapGesture.numberOfTapsRequired = 2 // num veces toca pantalla
        // lo añado a la vista
        self.view.addGestureRecognizer(tapGesture)
        
        // swipe gesture Recognizer
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(restoreView))
        swipeLeftGesture.direction = .left
        // lo añado a la vista
        self.view.addGestureRecognizer(swipeLeftGesture)
    }
    
    @objc func animateView(){
        UIView.animate(withDuration: 2.0) {
            if let v = self.myLoader {
                let newFrame = CGRect(x: v.frame.origin.x, y: v.frame.origin.y + 200, width: v.frame.width, height: v.frame.height)
                v.frame = newFrame
            }
            
            // Cambiamos el CornerRadius del Rectangle Rojo
            self.redRectangle.layer.cornerRadius = 50
            self.redRectangle.backgroundColor = UIColor.blue
        }
    }
    
    @objc func restoreView(){
        UIView.animate(withDuration: 2.0, animations: {
            if let v = self.myLoader {
                let newFrame = CGRect(x: 0, y: 0, width: v.frame.width, height: v.frame.height)
                v.frame = newFrame
            }
        }) { (stop: Bool) in
            UIView.animate(withDuration: 2.0, animations: {
                self.redRectangle.layer.cornerRadius = 0
                self.redRectangle.backgroundColor = UIColor.red
            })
        }
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
