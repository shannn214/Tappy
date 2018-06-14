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
    @IBOutlet weak var cardGuideViewTopConstraint: NSLayoutConstraint!

    var maskLayer: MaskLayer!

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
        
        cardGuideViewTopConstraint.constant = UIScreen.main.bounds.height * 0.55

    }

    func cardGuideViewAnimation() {

        UIView.animate(withDuration: 0.3, animations: {

            self.cardGuideView.alpha = 1
            self.cardGuideViewWidth.constant = 0
            self.cardGuideViewHeight.constant = 128
            self.view.layoutIfNeeded()

        }) { [weak self] (_) in

            UIView.animate(withDuration: 0.35, animations: {
                self?.cardGuideViewWidth.constant = 240
                self?.didMove(toParentViewController: self)
                self?.view.layoutIfNeeded()
            })

        }

        self.view.layoutIfNeeded()

    }

    func createMaskLayer() {

        maskLayer = MaskLayer()

        if UIScreen.main.bounds.height > 740 {

            maskLayer.createMask(rect: SHConstants.cardMaskBezRect,
                                 roundedRect: SHConstants.cardMaskRRForX,
                                 cornerRadius: SHConstants.maskCornerRadius)

        } else {

            maskLayer.createMask(rect: SHConstants.cardMaskBezRect,
                                 roundedRect: SHConstants.cardMaskRoundedRect,
                                 cornerRadius: SHConstants.maskCornerRadius)

        }

        view.layer.addSublayer(maskLayer)

    }

    @IBAction func cardGuideAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }

}
