//
//  PlayerViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SDWebImage
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerPanelView: PlayerPanelView!
    @IBOutlet weak var backgroundCover: UIImageView!

    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

        let touchPoint = sender.location(in: self.view.window)
        let touchTrans = sender.translation(in: self.view.window)

        if sender.state == UIGestureRecognizerState.began {
//            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchTrans.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 200 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }

    }

}
