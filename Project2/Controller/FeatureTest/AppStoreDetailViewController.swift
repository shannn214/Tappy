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

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initialSetup() {

//        self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 1.2)

        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 1.2)

        self.view.layer.cornerRadius = 20
        self.view.clipsToBounds = true

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapCellBeforeLose(sender:)))
        longPressGesture.minimumPressDuration = 0.1
        self.view.addGestureRecognizer(longPressGesture)

    }

    @objc func tapCellBeforeLose(sender: UILongPressGestureRecognizer) {

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
                       options: .beginFromCurrentState,
                       animations: {
                            self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       }, completion: nil)

    }

    func handleLongPressEnded() {

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .beginFromCurrentState,
                       animations: {
                            self.view.transform = CGAffineTransform.identity
                       }, completion: nil)

    }

    func changeToFullScreen() {

        self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.layer.cornerRadius = 0

    }

}
