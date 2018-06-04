//
//  GameViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import Instructions

protocol GameViewControllerDelegate: class {

    func gameMapDidTap(controller: GameViewController, position: CGFloat)

}

class GameViewController: UIViewController {

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var movingBtn: UIButton!
    @IBOutlet weak var gameMapContainer: UIView!

    @IBOutlet var tapGesture: UITapGestureRecognizer!

    weak var delegate: GameViewControllerDelegate?

    var distance = 0.0
    var checkLevel = 0
    let CDButtonArray = [UIButton(), UIButton()]
    let firstLogin = UserDefaults.standard

    var scrollView: UIScrollView!
    var imageView: UIImageView!

    var gameMapViewController: GameMapTestViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetting()

        LevelStatusManager.shared.showNewLevel()
        DBProvider.shared.getSortedArray()

        tapGesture.cancelsTouchesInView = false

        progress.isHidden = true
        movingBtn.isHidden = true

    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {

        let tapPoint = sender.location(in: view)

        switch sender.state {
        case .ended:
            let pop = PopView()
            pop.center = sender.location(in: view)
            view.addSubview(pop)
            let point = view.window?.convert(tapPoint, to: gameMapViewController?.gameMapScrollView)
            let dddd = point?.x

            if Int(dddd!) < Int((self.gameMapViewController?.gameMapScrollView.monster.center.x)!) {
                self.gameMapViewController?.gameMapScrollView.monster.image = #imageLiteral(resourceName: "left_pink")
            } else {
                self.gameMapViewController?.gameMapScrollView.monster.image = #imageLiteral(resourceName: "right_pink")
            }

            UIView.animate(withDuration: 0.4) {
                self.gameMapViewController?.gameMapScrollView.monster.frame = CGRect(x: (point?.x)!,
                                                                   y: 77 * (self.gameMapViewController?.gameMapScrollView.mapImageView.bounds.height)!/100,
                                                                   width: 75, height: 62)
            }
        default:
            print("Nope")
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let gameMapVC = segue.destination as? GameMapTestViewController {
//            self.delegate = gameMapVC
            self.gameMapViewController = gameMapVC
        }

    }

    func initialSetting() {

        progress.progress = 0
        movingBtn.isHidden = false
        //false for test

        if firstLogin.value(forKey: "firstLogin") == nil {
            getInfoData()
            LevelStatusManager.shared.initialGame()
            firstLogin.set(true, forKey: "firstLogin")

            popUpView()
        } else {
            //TODO
        }

        //For test
//        popUpView()

    }

    func getInfoData() {

        let uriManager = SpotifyUrisManager.createManagerFromFile()

        for dataIndex in 0...uriManager.uris.count - 1 {
            SpotifyTrackManager.shared.getTrackInfo(trackUri: uriManager.uris[dataIndex].trackUri,
                                                    albumUri: uriManager.uris[dataIndex].albumUri,
                                                    level: uriManager.uris[dataIndex].level)
        }

    }

    func popUpView() {
        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = self.view.frame
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.view.alpha = 0
        popUpRecordView.popUpIntro()

        UIView.animate(withDuration: 0.2) {
            popUpRecordView.view.alpha = 1
            popUpRecordView.didMove(toParentViewController: self)
        }
    }

}
