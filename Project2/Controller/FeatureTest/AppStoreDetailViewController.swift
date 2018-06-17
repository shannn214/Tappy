//
//  AppStoreDetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class AppStoreDetailViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backgroundView: UIView!

    var gesture: UIGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initialSetup() {

        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 1.2)

        self.view.layer.cornerRadius = 20
        self.view.clipsToBounds = true

//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapCellBeforeLose(sender:)))
//        longPressGesture.minimumPressDuration = 0
//        longPressGesture.delegate = self
//        self.view.addGestureRecognizer(longPressGesture)

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCellVC(sender:)))
//        tapGesture.delegate = self
//        self.view.addGestureRecognizer(tapGesture)

    }

    @objc func tapCellVC(sender: UITapGestureRecognizer) {

//        if sender.state == .began {
//
//            handleLongPressBegan()
//
//        } else if sender.state == .cancelled || sender.state == .ended {
//
//            handleLongPressEnded()
//
//        }

    }

    @objc func tapCellBeforeLose(sender: UILongPressGestureRecognizer) {

//        let touchPoint = sender.location(in: self.view.window)

//        sender.allowableMovement = 1

        if sender.state == .began {

            handleLongPressBegan()

        } else if sender.state == .cancelled || sender.state == .ended {

            handleLongPressEnded()

        }

    }

    func handleLongPressBegan() {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                            self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       }, completion: nil)

    }

    func handleLongPressEnded() {

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                            self.view.transform = CGAffineTransform.identity
                       }, completion: nil)

    }

    func changeToFullScreen() {

        self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.layer.cornerRadius = 0

    }

}

extension AppStoreDetailViewController: UIGestureRecognizerDelegate {

//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        return true
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        if otherGestureRecognizer.state == .began {
//            return true
//        }
//        return false
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//
//        if touch.phase == .began {
//
//            handleLongPressBegan()
//

//        } else if touch.location(in: view) != touch.previousLocation(in: view) {
//
//            handleLongPressEnded()
//
//        }
//
//        return false
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        if otherGestureRecognizer.view is UIScrollView {
//
//            handleLongPressEnded()
//
//        }
//
//        if otherGestureRecognizer.state == .began {
//            handleLongPressEnded()
//        }
//
//        return true
//    }
}
