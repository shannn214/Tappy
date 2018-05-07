//
//  GameViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginManager.shared.updateAfterLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
    }

}
