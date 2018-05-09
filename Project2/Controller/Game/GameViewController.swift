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

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var movingBtn: UIButton!
    @IBOutlet weak var gameMapView: GameMapViewController!

    let locationManager = CLLocationManager()
    var distance = 0.0
    var locations = [CLLocation]()

    let CDButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        progress.progress = 0
        movingBtn.isHidden = true

        createButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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

    func createButton() {

        CDButton.frame = CGRect(x: 49 * gameMapView.bounds.width/100, y: 65 * gameMapView.bounds.height/100, width: 40, height: 40)
        CDButton.setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
        self.gameMapView.addSubview(CDButton)
        CDButton.isHidden = true
        CDButton.addTarget(self, action: #selector(showRecordInfo), for: .touchUpInside)

    }

    @objc func showRecordInfo() {
        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = self.view.frame
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.didMove(toParentViewController: self)

        LoginManager.shared.playMusic()
    }

    @IBAction func movingButton(_ sender: Any) {

        movingBtn.isHidden = true
        progress.progress = 0
        distance = 0

        self.gameMapView.check = true
        self.gameMapView.setNeedsDisplay()

        CDButton.isHidden = false

        test()

    }

    func test() {
        let spotifyUrlString = "https://api.spotify.com/v1/tracks/3V9SgblMQCt5LyepDyHyEV"

        guard let url = URL(string: spotifyUrlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            guard let data = data else { return }

            let dataAsString = String(data: data, encoding: .utf8)

            print(dataAsString)

        }.resume()
    }

}
