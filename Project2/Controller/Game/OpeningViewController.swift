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

    var contentArray: [String] = [SHConstants.openingNotice, SHConstants.openingOne, SHConstants.openingTwo, SHConstants.openingThree, SHConstants.openingFour, SHConstants.openingFive]

    var buttonLabelArray: [String] = [SHConstants.openingNoticeBtn, SHConstants.openingOneBtn, SHConstants.openingTwoBtn, SHConstants.openingThreeBtn, SHConstants.openingFourBtn, SHConstants.openingFiveBtn]

    var currentIndex = 0

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

        SpotifyManager.shared.getUserInfo {

            if SpotifyManager.shared.userStatus == SpotifyManager.shared.premiumUser {

                self.openingTextView.text = self.contentArray[1]

                self.openingButton.setTitle(self.buttonLabelArray[1], for: .normal)

                self.currentIndex = 2

            } else {

                self.openingTextView.text = self.contentArray[0]

                self.openingButton.setTitle(self.buttonLabelArray[0], for: .normal)

                self.currentIndex = 1

            }

        }

    }

    func changeStoryContent(index: Int) {

            openingTextView.text = contentArray[index]

            openingButton.setTitle(buttonLabelArray[index], for: .normal)

            currentIndex += 1

    }

    @IBAction func openingAction(_ sender: Any) {

        if currentIndex < 6 {

            changeStoryContent(index: currentIndex)

        } else {

            let delegate = UIApplication.shared.delegate as? AppDelegate

            delegate?.window?.rootViewController = UIStoryboard.mainStoryboard().instantiateInitialViewController()

        }

    }

}
