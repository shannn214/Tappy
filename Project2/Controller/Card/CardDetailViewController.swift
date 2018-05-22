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

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!

    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    let initialPoint = CGPoint(x: 0, y: 0)

    weak var delegate: CardDetailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    
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
                self.view.frame = CGRect(x: 0,
                                         y: touchTrans.y,
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height
                )
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialPoint.y > 300 {
                // Back to cell view
                self.delegate?.cardDetailDidTransition(controller: self)

            } else {
                // Back to full screen
                UIView.animate(withDuration: 0.3,
                               animations: { self.view.frame = CGRect(x: 0,
                                                                      y: 0,
                                                                      width: self.view.frame.size.width,
                                                                      height: self.view.frame.size.height
                                                                      )
                })
            }
        }

    }

    func changeContraintToFullScreen() {

        leadingContraint.constant = 200
        view.layoutIfNeeded()
        panGesture.isEnabled = true

    }

    func changeConstraintToCellSize() {

        leadingContraint.constant = 20
        view.layoutIfNeeded()
        panGesture.isEnabled = false
    }

}

extension CardDetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return panGesture.isEnabled
    }
}
