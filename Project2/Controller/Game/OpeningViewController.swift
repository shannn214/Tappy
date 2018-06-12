//
//  OpeningViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {

    @IBOutlet weak var openingView: UIView!
    @IBOutlet weak var openingTextView: UITextView!
    @IBOutlet weak var openingButton: UIButton!

//    var secondTouchHandler: (() -> Void)?
//    var thirdTouchHandler: (() -> Void)?
//    var forthTouchHandler: (() -> Void)?

//    var touchArray = [() -> Void]()
    var handlerArray: [() -> Void] = [ {}, {}, {}, {}]
    
    var textIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setup() {

        openingView.layer.cornerRadius = 20

        openingButton.layer.cornerRadius = 15
        
    }

    func textOne() {

        openingTextView.text = Constants.openingOne
        
        textIndex += 1

    }

    func textTwo() {

        openingTextView.text = Constants.openingTwo
        
        textIndex += 1

    }

    func textThree() {

        openingTextView.text = Constants.openingThree
        
        textIndex += 1

    }

    func textFour() {

        openingTextView.text = Constants.openingFour
        
        textIndex += 1

    }

    func textFive() {

        openingTextView.text = Constants.openingFive

    }

    @IBAction func openingAction(_ sender: Any) {

        switch textIndex {
        case 0:
            textTwo()
        case 1:
            textThree()
        case 2:
            textFour()
        case 3:
            textFive()
        default:
            break
        }
        
    }

}
