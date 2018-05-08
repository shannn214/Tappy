//
//  GameViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import CoreLocation

class GameViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var movingBtn: UIButton!
    
    let locationManager = CLLocationManager()
    var distance = 0.0
    var locations = [CLLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        progress.progress = 0
        movingBtn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            print("Please enable getting location.")
        } else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation: CLLocation = locations[0]
        print("\(curLocation.coordinate)")
        
        for location in locations as [CLLocation] {
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                    let complete = 25.0
                    print("-----------")
                    print(distance)
                    if distance <= complete {
                        progress.progress = Float(distance) / Float(complete)
                    } else {
                        progress.progress = Float(complete)
                        movingBtn.isHidden = false
                    }
                }
                self.locations.append(location)
            }
        }
    }
    
    @IBAction func movingButton(_ sender: Any) {
        movingBtn.isHidden = true
        progress.progress = 0
        distance = 0
    }
    
}
