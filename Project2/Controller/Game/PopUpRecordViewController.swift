//
//  PopUpRecordViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import SDWebImage

protocol PopUpViewDelegate: class {
    func showCardViewMask(_ controller: PopUpRecordViewController)
}

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
    @IBOutlet weak var firstGuideViewWidth: NSLayoutConstraint!
    @IBOutlet weak var firstGuideViewHeight: NSLayoutConstraint!

    @IBOutlet weak var secondGuideViewButton: UIButton!
    @IBOutlet weak var secondGuideView: UIView!
    @IBOutlet weak var secondGuideViewHeight: NSLayoutConstraint!
    @IBOutlet weak var secondGuideViewWidth: NSLayoutConstraint!

    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    var propTouchHandler: (() -> Void)?
    var startGuideFlowHandler: (() -> Void)?
    var firstGuideTouchHandler: (() -> Void)?
    var firstPropTouchHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        introViewSetup()
        propViewSetup()
        firstGuideViewSetup()
        secondGuideSetup()

        self.view.backgroundColor = AppColor.popUpBGColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func secondGuideSetup() {

        secondGuideViewButton.layer.cornerRadius = 15
        self.secondGuideView.layer.cornerRadius = 20
        self.secondGuideView.alpha = 1
        self.secondGuideView.isHidden = true
        secondGuideView.frame.size = CGSize(width: 0, height: 0)
        self.secondGuideViewWidth.constant = 0
        self.secondGuideViewHeight.constant = 0

    }

    private func firstGuideViewSetup() {

        firstGuideButton.layer.cornerRadius = 15
        self.firstGuideView.layer.cornerRadius = 20
        self.firstGuideView.alpha = 1
        self.firstGuideView.isHidden = true
        firstGuideView.frame.size = CGSize(width: 0, height: 0)
        self.firstGuideViewWidth.constant = 0
        self.firstGuideViewHeight.constant = 0

    }

    private func introViewSetup() {

        self.introView.layer.cornerRadius = 20
        self.introTextView.text = SHConstants.introText
        startGameButton.layer.cornerRadius = 15

    }

    private func propViewSetup() {

        self.propView.layer.cornerRadius = 20
        getPropButton.layer.cornerRadius = 15
        recordCover.layer.cornerRadius = 60

    }

    func popUpfirstGuide(parent: UIViewController) {

        self.propView.isHidden = true
        self.introView.isHidden = true
        self.secondGuideView.isHidden = true
        self.firstGuideView.isHidden = false

        UIView.animate(withDuration: 0.3, animations: {

            self.firstGuideView.alpha = 1
            self.firstGuideViewWidth.constant = 0
            self.firstGuideViewHeight.constant = 128
            self.view.layoutIfNeeded()

        }) { [weak self] (_) in

            UIView.animate(withDuration: 0.35, animations: {
                self?.firstGuideViewWidth.constant = 240
                self?.didMove(toParentViewController: parent)
                self?.view.layoutIfNeeded()
            })

        }

    }

    func popUpsecondGuide(parent: UIViewController) {

        self.secondGuideView.isHidden = false
        self.propView.isHidden = true
        self.introView.isHidden = true
        self.firstGuideView.isHidden = true

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {

                self.secondGuideView.alpha = 1
                self.secondGuideViewWidth.constant = 0
                self.secondGuideViewHeight.constant = 128
                self.view.layoutIfNeeded()

            }) { [weak self] (_) in

                UIView.animate(withDuration: 0.35, animations: {
                    self?.secondGuideViewWidth.constant = 240
                    self?.didMove(toParentViewController: parent)
                    self?.view.layoutIfNeeded()
                })

            }

        }

    }

    func popUpIntro() {

        self.view.alpha = 0
        self.propView.isHidden = true
        self.introView.isHidden = false
        self.firstGuideView.isHidden = true
        self.secondGuideView.isHidden = true

    }

    func popProp(hint: String, image: String) {

        self.recordTitle.text = hint
        self.recordCover.sd_setImage(with: URL(string: image))
        self.view.alpha = 0
        self.propView.isHidden = false
        self.introView.isHidden = true
        self.firstGuideView.isHidden = true
        self.secondGuideView.isHidden = true

    }

    @IBAction func firstGuideAction(_ sender: Any) {

        firstGuideTouchHandler?()

        self.view.removeFromSuperview()
    }

    @IBAction func secondGuideAction(_ sender: Any) {

        tabBarController?.selectedIndex = 1

        NotificationCenter.default.post(name: .showCardGuideMaskAction, object: nil)

        self.view.removeFromSuperview()

    }

    @IBAction func startButton(_ sender: Any) {

        startGuideFlowHandler?()

        self.view.removeFromSuperview()
    }

    @IBAction func leaveButton(_ sender: Any) {

        propTouchHandler?()

        self.view.removeFromSuperview()

        if LevelStatusManager.shared.level == 1 {
            firstPropTouchHandler?()
        }

    }

}
