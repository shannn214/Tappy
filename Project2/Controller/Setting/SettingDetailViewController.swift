//
//  SettingDetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class SettingDetailViewController: UIViewController {

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
