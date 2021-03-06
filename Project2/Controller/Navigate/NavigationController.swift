//
//  NavigationController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNav()
    }

    private func setupNav() {

//        self.navigationBar.barTintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

    }

}
