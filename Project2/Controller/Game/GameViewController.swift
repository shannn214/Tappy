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
    var checkLevel = 0
    let CDButtonArray = [UIButton(), UIButton()]
    let firstLogin = UserDefaults.standard

//    let databaseManager = DBManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        progress.progress = 0
        movingBtn.isHidden = false
        //false for test

        createButton()

        if firstLogin.value(forKey: "firstLogin") == nil {
            LevelStatusManager.shared.createLevel(newLevel: 0)
            for dataIndex in 0...9 {
                getInfoData(uriIndex: dataIndex)
            }
            firstLogin.set("true", forKey: "firstLogin")
        } else {
            //TODO
        }

        LevelStatusManager.shared.showNewLevel()
        DBProvider.shared.getSortedArray()
//        self.checkLevel = LevelStatusManager.shared.level! + 1

    }

    func getInfoData(uriIndex: Int) {

        let uriManager = SpotifyUrisManager.createManagerFromFile()
        guard uriManager.uris.count > 0 else { return }

        SpotifyTrackManager.shared.getTrackInfo(trackUri: uriManager.uris[uriIndex].trackUri,
                                                albumUri: uriManager.uris[uriIndex].albumUri,
                                                level: uriManager.uris[uriIndex].level)

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

        for btnIndex in 0...1 {
            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            self.gameMapView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
            CDButtonArray[btnIndex].addTarget(self, action: #selector(showRecordInfo), for: .touchUpInside)
            CDButtonArray[btnIndex].tag = btnIndex
        }

        CDButtonArray[0].frame = CGRect(x: 49 * gameMapView.bounds.width/100, y: 65 * gameMapView.bounds.height/100, width: 40, height: 40)
        CDButtonArray[1].frame = CGRect(x: 20 * gameMapView.bounds.width/100, y: 40 * gameMapView.bounds.height/100, width: 40, height: 40)

    }

    @objc func showRecordInfo(sender: UIButton!) {
        popUpView()

        var btnSendTag: UIButton = sender
        switch btnSendTag.tag {
        case 0:
            SpotifyManager.shared.playMusic(track: DBProvider.shared.sortedArray![0].trackUri)
            //use database to insert track value
        default:
            SpotifyManager.shared.playMusic(track: DBProvider.shared.sortedArray![1].trackUri)
        }

    }

    @IBAction func movingButton(_ sender: Any) {

        movingBtn.isHidden = true
        progress.progress = 0
        distance = 0

        self.gameMapView.check = true
        self.gameMapView.setNeedsDisplay()

        //When user press moving button, database should add one object into the collection view.

        self.checkLevel = LevelStatusManager.shared.level! + 1

        LevelStatusManager.shared.updateLevel(newLevel: self.checkLevel)

        if checkLevel == 1 {
            CDButtonArray[0].isHidden = false
        } else {
            CDButtonArray[1].isHidden = false
        }

    }

    func popUpView() {
        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = self.view.frame
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.view.alpha = 0
        UIView.animate(withDuration: 0.2) {
            popUpRecordView.view.alpha = 1
            popUpRecordView.didMove(toParentViewController: self)
        }
    }

}
