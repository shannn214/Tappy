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

        self.view.layer.cornerRadius = 20
        self.view.clipsToBounds = true

    }

    func changeToFullScreen() {

        self.view.layer.cornerRadius = 0

    }

}
