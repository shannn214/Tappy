//
//  CardDetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/21.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

protocol CardDetailDelegate: class {

    func cardDetailDidTransition(controller: CardDetailViewController)

}

class CardDetailViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    @IBOutlet weak var cardImageHeight: NSLayoutConstraint!
    @IBOutlet weak var cardImageWidth: NSLayoutConstraint!

    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    let initialPoint = CGPoint(x: 0, y: 0)

    weak var delegate: CardDetailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        cardImage.layer.cornerRadius = 20
        cardImageWidth.constant = UIScreen.main.bounds.width * 0.45
        cardImageHeight.constant = UIScreen.main.bounds.width * 0.45
        leadingContraint.constant = UIScreen.main.bounds.width * 0.025

        panGesture.delegate = self
        panGesture.isEnabled = false
    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

        let touchPoint = sender.location(in: self.view.window)
        let touchTrans = sender.translation(in: self.view.window)

        if sender.state == UIGestureRecognizerState.began {
            //            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialPoint.y > 0 && touchTrans.y > 0 {
                self.view.frame = CGRect(x: touchTrans.x,
                                         y: touchTrans.y,
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height
                )

                backgroundView.alpha = 1 - touchTrans.y / 100
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialPoint.y > 300 {
                // Back to cell view
                self.delegate?.cardDetailDidTransition(controller: self)

            } else {
                // Back to full screen
                UIView.animate(withDuration: 0.3,
                               animations: { self.view.frame = CGRect(x: 0, y: 0,
                                                                      width: self.view.frame.size.width,
                                                                      height: self.view.frame.size.height
                                                                     )
                                             self.backgroundView.alpha = 1

                })
            }
        }

    }

    func changeContraintToFullScreen() {

        leadingContraint.constant = UIScreen.main.bounds.width * 0.125
        cardImageWidth.constant = UIScreen.main.bounds.width * 0.75
        cardImageHeight.constant = UIScreen.main.bounds.width * 0.75

        view.layoutIfNeeded()
        panGesture.isEnabled = true

    }

    func changeConstraintToCellSize() {

        cardImageWidth.constant = UIScreen.main.bounds.width * 0.45
        cardImageHeight.constant = UIScreen.main.bounds.width * 0.45
        leadingContraint.constant = UIScreen.main.bounds.width * 0.025
        view.layoutIfNeeded()
        panGesture.isEnabled = false

    }

}

extension CardDetailViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return panGesture.isEnabled
    }
}
