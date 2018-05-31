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
    
//    let coachMarksController = CoachMarksController()
//    let pointOfInsert = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetting()
//        setupLocation()

        LevelStatusManager.shared.showNewLevel()
        DBProvider.shared.getSortedArray()

        tapGesture.cancelsTouchesInView = false
//        tapGesture.isEnabled = false

        progress.isHidden = true
        movingBtn.isHidden = true
        
//        self.coachMarksController.delegate = self

    }


    @IBAction func tapped(_ sender: UITapGestureRecognizer) {

        let tapPoint = sender.location(in: view)

        switch sender.state {
        case .ended:
            let pop = PopView()
            pop.center = sender.location(in: view)
            view.addSubview(pop)
            let point = view.window?.convert(tapPoint, to: gameMapViewController?.scrollView)
            let dddd = point?.x

            if Int(dddd!) < Int((self.gameMapViewController?.monster.center.x)!) {
                self.gameMapViewController?.monster.image = #imageLiteral(resourceName: "left_pink")
            } else {
                self.gameMapViewController?.monster.image = #imageLiteral(resourceName: "right_pink")
            }

            UIView.animate(withDuration: 0.4) {
                self.gameMapViewController?.monster.frame = CGRect(x: (point?.x)!,
                                                                   y: 77 * (self.gameMapViewController?.imageView.bounds.height)!/100,
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
        popUpRecordView.propView.isHidden = true
        popUpRecordView.introView.isHidden = false

        UIView.animate(withDuration: 0.2) {
            popUpRecordView.view.alpha = 1
            popUpRecordView.didMove(toParentViewController: self)
        }
    }

//    override func viewDidAppear(_ animated: Bool) {
//
//        super.viewDidAppear(animated)
//        
//        self.coachMarksController.start(on: self)
//
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        self.coachMarksController.stop(immediately: true)
//    }

}

//extension GameViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
//    
//    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
//        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, withNextText: true, arrowOrientation: coachMark.arrowOrientation)
//        
//        coachViews.bodyView.hintLabel.text = "balalalalala"
//        coachViews.bodyView.nextLabel.text = "OKOK"
//        
//        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
//    }
//    
//    
//    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
//        return coachMarksController.helper.makeCoachMark(for: pointOfInsert)
//    }
//    
//    
//    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
//        return 1
//    }
//    
//}
