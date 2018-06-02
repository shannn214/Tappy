//
//  GuideViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/2.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var cardGuideView: UIView!
    @IBOutlet weak var cardGuideButton: UIButton!
    @IBOutlet weak var cardGuideViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cardGuideViewWidth: NSLayoutConstraint!

    let maskLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        createMaskLayer()
        self.view.bringSubview(toFront: cardGuideView)
        setupCardGuide()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupCardGuide() {

        cardGuideView.layer.cornerRadius = 20
        cardGuideButton.layer.cornerRadius = 15

        cardGuideView.frame.size = CGSize(width: 0, height: 0)

    }

    func cardGuideViewAnimation() {

        UIView.animate(withDuration: 0.3, animations: {

            self.cardGuideView.alpha = 1
            self.cardGuideViewWidth.constant = 0
            self.cardGuideViewHeight.constant = 128
            self.view.layoutIfNeeded()

        }) { (_) in

            UIView.animate(withDuration: 0.35, animations: {
                self.cardGuideViewWidth.constant = 240
                self.didMove(toParentViewController: self)
                self.view.layoutIfNeeded()
            })

        }

        self.view.layoutIfNeeded()

    }

    func createMaskLayer() {

        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 10, y: UIScreen.main.bounds.height * 0.4, width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45), cornerRadius: 20)
        path.append(maskPath.reversing())

        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor(displayP3Red: 24/255, green: 24/255, blue: 24/255, alpha: 0.7).cgColor
//        maskLayer.opacity = 0.7
        view.layer.addSublayer(maskLayer)

    }

    @IBAction func cardGuideAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }

}
