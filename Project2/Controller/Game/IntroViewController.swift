//
//  IntroViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var introButton: UIButton!

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewTwoTextView: UITextView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewThreeTextView: UITextView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFourTextView: UITextView!
    @IBOutlet weak var viewFive: UIView!
    @IBOutlet weak var viewFiveTextView: UITextView!

    @IBOutlet weak var viewOneButton: UIButton!
    @IBOutlet weak var viewTwoButton: UIButton!
    @IBOutlet weak var viewThreeButton: UIButton!
    @IBOutlet weak var viewFourButton: UIButton!
    @IBOutlet weak var viewFiveButton: UIButton!

    var touchHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        popViewSetUp()
        allViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func allViewSetup() {

        popUpView.isHidden = true
        viewTwo.isHidden = true
        viewThree.isHidden = true
        viewFour.isHidden = true
        viewFive.isHidden = true

        viewTwoTextView.text = Constants.openingTwo
        viewThreeTextView.text = Constants.openingThree
        viewFourTextView.text = Constants.openingFour
        viewFiveTextView.text = Constants.openingFive

        viewOne.layer.cornerRadius = 20
        viewTwo.layer.cornerRadius = 20
        viewThree.layer.cornerRadius = 20
        viewFour.layer.cornerRadius = 20
        viewFive.layer.cornerRadius = 20

        viewOneButton.layer.cornerRadius = 15
        viewTwoButton.layer.cornerRadius = 15
        viewThreeButton.layer.cornerRadius = 15
        viewFourButton.layer.cornerRadius = 15
        viewFiveButton.layer.cornerRadius = 15

    }

    private func popViewSetUp() {

        view.backgroundColor = UIColor.black
        popUpView.layer.cornerRadius = 20

        self.introButton.layer.cornerRadius = 15

    }

    @IBAction func actionOne(_ sender: Any) {
        viewOne.isHidden = true
        viewTwo.isHidden = false
//        touchHandler()
    }
    @IBAction func actionTwo(_ sender: Any) {
        viewTwo.isHidden = true
        viewThree.isHidden = false
    }
    @IBAction func actionThree(_ sender: Any) {
        viewThree.isHidden = true
        viewFour.isHidden = false
    }
    @IBAction func actionFour(_ sender: Any) {
        viewFour.isHidden = true
        viewFive.isHidden = false
    }
    @IBAction func actionFive(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = UIStoryboard.mainStoryboard().instantiateInitialViewController()
    }

    @IBAction func introNextAction(_ sender: Any) {
    }

}
