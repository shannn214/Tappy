//
//  PopUpRecordViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import SDWebImage

class PopUpRecordViewController: UIViewController {

    @IBOutlet weak var recordCover: UIImageView!
    @IBOutlet weak var recordTitle: UILabel!
    @IBOutlet weak var propView: UIView!
    @IBOutlet weak var introView: UIView!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var getPropButton: UIButton!
    @IBOutlet weak var firstGuideButton: UIButton!
    @IBOutlet weak var firstGuideView: UIView!

    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        introViewSetup()
        propViewSetup()
        firstGuideViewSetup()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

    }

    @IBAction func firstGuideAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func firstGuideViewSetup() {

        firstGuideButton.layer.cornerRadius = 15
        self.firstGuideView.layer.cornerRadius = 20

    }

    func introViewSetup() {

        self.introView.layer.cornerRadius = 20
        self.introTextView.text = "Yeah!!! \n I know you are a good man. \n I'll guide you to find the first record. \n \n GOGOGO!"
        startGameButton.layer.cornerRadius = 15

    }

    func propViewSetup() {

        self.propView.layer.cornerRadius = 20
        getPropButton.layer.cornerRadius = 15
        recordCover.layer.cornerRadius = 60

    }

    func popUpLastGuide() {

        self.propView.isHidden = true
        self.introView.isHidden = true
        self.firstGuideView.isHidden = true

    }

    func popUpfirstGuide() {

        self.propView.isHidden = true
        self.introView.isHidden = true
        self.firstGuideView.isHidden = false

    }

    func popUpIntro() {

        self.propView.isHidden = true
        self.introView.isHidden = false
        self.firstGuideView.isHidden = true

    }

    func popProp() {

        self.propView.isHidden = false
        self.introView.isHidden = true
        self.firstGuideView.isHidden = true

    }

    @IBAction func startButton(_ sender: Any) {
        // Note: Notify game map to change frame to first record position
        NotificationCenter.default.post(name: .startGuideFlow, object: nil)

        self.view.removeFromSuperview()
    }

    @IBAction func leaveButton(_ sender: Any) {

        NotificationCenter.default.post(name: .leavePropPopView, object: nil)

        self.view.removeFromSuperview()

    }

}
