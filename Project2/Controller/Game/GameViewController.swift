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
    @IBOutlet weak var gameMapContainer: UIView!

    @IBOutlet var tapGesture: UITapGestureRecognizer!

    let locationManager = CLLocationManager()
    var distance = 0.0
    var locations = [CLLocation]()
    var checkLevel = 0
    let CDButtonArray = [UIButton(), UIButton()]
    let firstLogin = UserDefaults.standard

    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetting()
        setupLocation()

        LevelStatusManager.shared.showNewLevel()
        DBProvider.shared.getSortedArray()

        tapGesture.cancelsTouchesInView = false

    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {

        switch sender.state {
        case .ended:
            let pop = PopView()
            pop.center = sender.location(in: view)
            view.addSubview(pop)
        default:
            print("Nope")
        }

    }

    func setupLocation() {

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }

    func initialSetting() {

        progress.progress = 0
        movingBtn.isHidden = false
        //false for test

        if firstLogin.value(forKey: "firstLogin") == nil {
            getInfoData()
            LevelStatusManager.shared.initialGame()
            firstLogin.set(true, forKey: "firstLogin")
        } else {
            //TODO
        }

    }

    func getInfoData() {

        let uriManager = SpotifyUrisManager.createManagerFromFile()

        for dataIndex in 0...uriManager.uris.count - 1 {
            SpotifyTrackManager.shared.getTrackInfo(trackUri: uriManager.uris[dataIndex].trackUri,
                                                    albumUri: uriManager.uris[dataIndex].albumUri,
                                                    level: uriManager.uris[dataIndex].level)
        }

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
//                    print("-----------")
//                    print(distance)
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

//    @objc func showRecordInfo(sender: UIButton!) {
//        popUpView()
//
//        var btnSendTag: UIButton = sender
//        switch btnSendTag.tag {
//        case 0:
//            SpotifyManager.shared.playMusic(track: DBProvider.shared.sortedArray![0].trackUri)
//            //use database to insert track value
//        default:
//            SpotifyManager.shared.playMusic(track: DBProvider.shared.sortedArray![1].trackUri)
//        }
//
//    }

    @IBAction func movingButton(_ sender: Any) {

        movingBtn.isHidden = false
        progress.progress = 0
        distance = 0

        self.checkLevel = LevelStatusManager.shared.level! + 1

        if self.checkLevel < 11 {
            LevelStatusManager.shared.updateLevel(newLevel: self.checkLevel)
        }

        NotificationCenter.default.post(
            name: .pressMovingButton,
            object: nil
        )

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
