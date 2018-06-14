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

    var handlerArray: [() -> Void] = [ {}, {}, {}, {}]

    var contentArray: [String] = [SHConstants.openingOne, SHConstants.openingTwo, SHConstants.openingThree, SHConstants.openingFour, SHConstants.openingFive]

    var buttonLabelArray: [String] = [SHConstants.openingOneBtn, SHConstants.openingTwoBtn, SHConstants.openingThreeBtn, SHConstants.openingFourBtn, SHConstants.openingFiveBtn]

    var currentIndex = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setup() {

        openingView.layer.cornerRadius = 20

        openingButton.layer.cornerRadius = 15

        openingTextView.text = contentArray[0]

        openingButton.setTitle(buttonLabelArray[0], for: .normal)

    }

    func changeStoryContent(index: Int) {

            openingTextView.text = contentArray[index]

            openingButton.setTitle(buttonLabelArray[index], for: .normal)

            currentIndex += 1

    }

    @IBAction func openingAction(_ sender: Any) {

        if currentIndex < 5 {

            changeStoryContent(index: currentIndex)

        } else {

            let delegate = UIApplication.shared.delegate as? AppDelegate

            delegate?.window?.rootViewController = UIStoryboard.mainStoryboard().instantiateInitialViewController()

        }

    }

}
